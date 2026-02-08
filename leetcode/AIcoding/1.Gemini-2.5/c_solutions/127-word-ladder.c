#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

static bool isOneCharDiff(const char *s1, const char *s2) {
    int diffCount = 0;
    // Assuming s1 and s2 have the same length as per problem constraints
    int len = strlen(s1); 
    for (int i = 0; i < len; i++) {
        if (s1[i] != s2[i]) {
            diffCount++;
        }
    }
    return diffCount == 1;
}

typedef struct {
    int wordIdx; // Index in the original wordList, -1 for beginWord
    int dist;
} QueueNode;

static QueueNode* queue;
static int head = 0;
static int tail = 0;
static int queueCapacity;

static void initQueue(int capacity) {
    queueCapacity = capacity;
    queue = (QueueNode*)malloc(sizeof(QueueNode) * capacity);
    head = 0;
    tail = 0;
}

static void enqueue(int wordIdx, int dist) {
    queue[tail].wordIdx = wordIdx;
    queue[tail].dist = dist;
    tail = (tail + 1) % queueCapacity;
}

static QueueNode dequeue() {
    QueueNode node = queue[head];
    head = (head + 1) % queueCapacity;
    return node;
}

static bool isQueueEmpty() {
    return head == tail;
}

int ladderLength(char *beginWord, char *endWord, char **wordList, int wordListSize) {
    // Check if endWord is in wordList. If not, no path exists.
    bool endWordFoundInList = false;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordList[i], endWord) == 0) {
            endWordFoundInList = true;
            break;
        }
    }
    if (!endWordFoundInList) {
        return 0;
    }

    // Visited array to keep track of words from wordList
    // Initialized to false by calloc
    bool *visited = (bool*)calloc(wordListSize, sizeof(bool));
    if (!visited) {
        // Handle memory allocation failure
        return 0; 
    }

    // Initialize queue. Max size is wordListSize + 1 (for beginWord)
    // Using wordListSize + 2 for a slightly safer buffer
    initQueue(wordListSize + 2); 

    // Enqueue beginWord as a special case (index -1) with distance 1
    enqueue(-1, 1);

    int result = 0;

    while (!isQueueEmpty()) {
        QueueNode current = dequeue();
        char *currentWord;

        if (current.wordIdx == -1) {
            currentWord = beginWord;
        } else {
            currentWord = wordList[current.wordIdx];
        }

        // If we reached the endWord, store the distance and break
        if (strcmp(currentWord, endWord) == 0) {
            result = current.dist;
            break;
        }

        // Explore neighbors from the wordList
        for (int i = 0; i < wordListSize; i++) {
            // Check if the word hasn't been visited and is one character different
            if (!visited[i] && isOneCharDiff(currentWord, wordList[i])) {
                visited[i] = true; // Mark as visited
                enqueue(i, current.dist + 1); // Enqueue with incremented distance
            }
        }
    }

    // Free allocated memory
    free(visited);
    free(queue); 

    return result;
}