#include <stdlib.h>
#include <string.h>

#define MAX_USERS 500
#define MAX_TWEETS 10000

typedef struct {
    int time;
    int tweetId;
} Tweet;

typedef struct {
    Tweet* tweets;
    int size;
    int capacity;
} User;

typedef struct {
    User* users[MAX_USERS];
    int** follows;
    int time;
} Twitter;

Twitter* twitterCreate() {
    Twitter* obj = (Twitter*)malloc(sizeof(Twitter));
    obj->time = 0;

    for (int i = 0; i < MAX_USERS; i++) {
        obj->users[i] = (User*)malloc(sizeof(User));
        obj->users[i]->tweets = (Tweet*)malloc(sizeof(Tweet) * 10);
        obj->users[i]->size = 0;
        obj->users[i]->capacity = 10;
    }

    obj->follows = (int**)malloc(sizeof(int*) * MAX_USERS);
    for (int i = 0; i < MAX_USERS; i++) {
        obj->follows[i] = (int*)calloc(MAX_USERS, sizeof(int));
        obj->follows[i][i] = 1;
    }

    return obj;
}

void twitterPostTweet(Twitter* obj, int userId, int tweetId) {
    User* user = obj->users[userId];
    if (user->size == user->capacity) {
        user->capacity *= 2;
        user->tweets = (Tweet*)realloc(user->tweets, sizeof(Tweet) * user->capacity);
    }
    user->tweets[user->size].time = obj->time++;
    user->tweets[user->size].tweetId = tweetId;
    user->size++;
}

int* twitterGetNewsFeed(Twitter* obj, int userId, int* retSize) {
    int* result = (int*)malloc(sizeof(int) * 10);
    *retSize = 0;

    Tweet heap[5000];
    int heapSize = 0;

    for (int i = 0; i < MAX_USERS; i++) {
        if (obj->follows[userId][i]) {
            User* user = obj->users[i];
            for (int j = user->size - 1; j >= 0 && j >= user->size - 10; j--) {
                heap[heapSize++] = user->tweets[j];
            }
        }
    }

    for (int i = heapSize / 2 - 1; i >= 0; i--) {
        int parent = i;
        while (parent * 2 + 1 < heapSize) {
            int child = parent * 2 + 1;
            if (child + 1 < heapSize && heap[child + 1].time > heap[child].time) {
                child++;
            }
            if (heap[child].time > heap[parent].time) {
                Tweet temp = heap[parent];
                heap[parent] = heap[child];
                heap[child] = temp;
                parent = child;
            } else {
                break;
            }
        }
    }

    for (int i = 0; i < 10 && heapSize > 0; i++) {
        result[(*retSize)++] = heap[0].tweetId;

        heap[0] = heap[--heapSize];
        int parent = 0;
        while (parent * 2 + 1 < heapSize) {
            int child = parent * 2 + 1;
            if (child + 1 < heapSize && heap[child + 1].time > heap[child].time) {
                child++;
            }
            if (heap[child].time > heap[parent].time) {
                Tweet temp = heap[parent];
                heap[parent] = heap[child];
                heap[child] = temp;
                parent = child;
            } else {
                break;
            }
        }
    }

    return result;
}

void twitterFollow(Twitter* obj, int followerId, int followeeId) {
    obj->follows[followerId][followeeId] = 1;
}

void twitterUnfollow(Twitter* obj, int followerId, int followeeId) {
    if (followerId != followeeId) {
        obj->follows[followerId][followeeId] = 0;
    }
}

void twitterFree(Twitter* obj) {
    for (int i = 0; i < MAX_USERS; i++) {
        free(obj->users[i]->tweets);
        free(obj->users[i]);
        free(obj->follows[i]);
    }
    free(obj->follows);
    free(obj);
}