#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

#define MAX_USERS 10001
#define MAX_NEWS_FEED_SIZE 10

static int global_timestamp = 0;

typedef struct Tweet {
    int tweetId;
    int timestamp;
    struct Tweet* next; // Linked list of tweets for a user (most recent at head)
} Tweet;

typedef struct FollowNode {
    int followeeId;
    struct FollowNode* next;
} FollowNode;

typedef struct User {
    int userId;
    Tweet* tweets; // Head of the linked list of tweets posted by this user
    FollowNode* follows_head; // Head of linked list of users this user follows
} User;

typedef struct {
    User* users[MAX_USERS]; // Array of pointers to User structs
} Twitter;

Tweet* createTweet(int tweetId) {
    Tweet* newTweet = (Tweet*)malloc(sizeof(Tweet));
    newTweet->tweetId = tweetId;
    newTweet->timestamp = global_timestamp++;
    newTweet->next = NULL;
    return newTweet;
}

User* createUser(int userId) {
    User* newUser = (User*)malloc(sizeof(User));
    newUser->userId = userId;
    newUser->tweets = NULL;
    newUser->follows_head = NULL;
    return newUser;
}

Twitter* twitterCreate() {
    Twitter* obj = (Twitter*)malloc(sizeof(Twitter));
    memset(obj->users, 0, sizeof(User*) * MAX_USERS);
    global_timestamp = 0;
    return obj;
}

void twitterPostTweet(Twitter* obj, int userId, int tweetId) {
    if (obj->users[userId] == NULL) {
        obj->users[userId] = createUser(userId);
    }

    Tweet* newTweet = createTweet(tweetId);
    newTweet->next = obj->users[userId]->tweets;
    obj->users[userId]->tweets = newTweet;
}

void twitterFollow(Twitter* obj, int followerId, int followeeId) {
    if (followerId == followeeId) {
        return;
    }

    if (obj->users[followerId] == NULL) {
        obj->users[followerId] = createUser(followerId);
    }

    FollowNode* current = obj->users[followerId]->follows_head;
    while (current != NULL) {
        if (current->followeeId == followeeId) {
            return;
        }
        current = current->next;
    }

    FollowNode* newNode = (FollowNode*)malloc(sizeof(FollowNode));
    newNode->followeeId = followeeId;
    newNode->next = obj->users[followerId]->follows_head;
    obj->users[followerId]->follows_head = newNode;
}

void twitterUnfollow(Twitter* obj, int followerId, int followeeId) {
    if (followerId == followeeId) {
        return;
    }

    if (obj->users[followerId] == NULL) {
        return;
    }

    FollowNode* current = obj->users[followerId]->follows_head;
    FollowNode* prev = NULL;

    while (current != NULL && current->followeeId != followeeId) {
        prev = current;
        current = current->next;
    }

    if (current != NULL) {
        if (prev == NULL) {
            obj->users[followerId]->follows_head = current->next;
        } else {
            prev->next = current->next;
        }
        free(current);
    }
}

typedef struct HeapNode {
    Tweet* tweetPtr;
    int userId;
} HeapNode;

typedef struct MaxHeap {
    HeapNode* nodes;
    int capacity;
    int size;
} MaxHeap;

MaxHeap* createMaxHeap(int capacity) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->nodes = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swapHeapNodes(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyDown(MaxHeap* heap, int index) {
    int largest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->nodes[left].tweetPtr->timestamp > heap->nodes[largest].tweetPtr->timestamp) {
        largest = left;
    }
    if (right < heap->size && heap->nodes[right].tweetPtr->timestamp > heap->nodes[largest].tweetPtr->timestamp) {
        largest = right;
    }

    if (largest != index) {
        swapHeapNodes(&heap->nodes[index], &heap->nodes[largest]);
        heapifyDown(heap, largest);
    }
}

void heapifyUp(MaxHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->nodes[index].tweetPtr->timestamp > heap->nodes[parent].tweetPtr->timestamp) {
        swapHeapNodes(&heap->nodes[index], &heap->nodes[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void insertHeap(MaxHeap* heap, Tweet* tweetPtr, int userId) {
    if (heap->size == heap->capacity) {
        return;
    }
    heap->nodes[heap->size].tweetPtr = tweetPtr;
    heap->nodes[heap->size].userId = userId;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

HeapNode extractMax(MaxHeap* heap) {
    if (heap->size == 0) {
        HeapNode empty = {NULL, -1};
        return empty;
    }
    HeapNode root = heap->nodes[0];
    heap->nodes[0] = heap->nodes[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

void freeMaxHeap(MaxHeap* heap) {
    if (heap == NULL) return;
    free(heap->nodes);
    free(heap);
}

int* twitterGetNewsFeed(Twitter* obj, int userId, int* retSize) {
    *retSize = 0;
    int* newsFeed = (int*)malloc(sizeof(int) * MAX_NEWS_FEED_SIZE);

    if (obj->users[userId] == NULL) {
        return newsFeed;
    }

    HeapNode* initialHeapNodes = (HeapNode*)malloc(sizeof(HeapNode) * MAX_USERS);
    int initialHeapSize = 0;

    if (obj->users[userId]->tweets != NULL) {
        initialHeapNodes[initialHeapSize].tweetPtr = obj->users[userId]->tweets;
        initialHeapNodes[initialHeapSize].userId = userId;
        initialHeapSize++;
    }

    FollowNode* currentFollow = obj->users[userId]->follows_head;
    while (currentFollow != NULL) {
        int followeeId = currentFollow->followeeId;
        if (obj->users[followeeId] != NULL && obj->users[followeeId]->tweets != NULL) {
            initialHeapNodes[initialHeapSize].tweetPtr = obj->users[followeeId]->tweets;
            initialHeapNodes[initialHeapSize].userId = followeeId;
            initialHeapSize++;
        }
        currentFollow = currentFollow->next;
    }

    if (initialHeapSize == 0) {
        free(initialHeapNodes);
        return newsFeed;
    }

    MaxHeap* heap = createMaxHeap(initialHeapSize);
    heap->size = initialHeapSize;
    for (int i = 0; i < initialHeapSize; ++i) {
        heap->nodes[i] = initialHeapNodes[i];
    }
    for (int i = (heap->size / 2) - 1; i >= 0; --i) {
        heapifyDown(heap, i);
    }
    free(initialHeapNodes);

    for (int k = 0; k < MAX_NEWS_FEED_SIZE && heap->size > 0; ++k) {
        HeapNode top = extractMax(heap);
        newsFeed[*retSize] = top.tweetPtr->tweetId;
        (*retSize)++;

        if (top.tweetPtr->next != NULL) {
            insertHeap(heap, top.tweetPtr->next, top.userId);
        }
    }

    freeMaxHeap(heap);
    return newsFeed;
}

void freeTweets(Tweet* head) {
    Tweet* current = head;
    while (current != NULL) {
        Tweet* next = current->next;
        free(current);
        current = next;
    }
}

void freeFollows(FollowNode* head) {
    FollowNode* current = head;
    while (current != NULL) {
        FollowNode* next = current->next;
        free(current);
        current = next;
    }
}

void twitterFree(Twitter* obj) {
    if (obj == NULL) return;

    for (int i = 1; i < MAX_USERS; ++i) {
        if (obj->users[i] != NULL) {
            freeTweets(obj->users[i]->tweets);
            freeFollows(obj->users[i]->follows_head);
            free(obj->users[i]);
        }
    }
    free(obj);
}