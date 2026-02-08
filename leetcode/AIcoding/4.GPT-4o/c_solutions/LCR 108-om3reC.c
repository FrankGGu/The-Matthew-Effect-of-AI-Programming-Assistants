#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LEN 100
#define MAX_QUEUE_SIZE 10000

typedef struct {
    char **words;
    int front;
    int rear;
} Queue;

Queue* createQueue() {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->words = (char **)malloc(MAX_QUEUE_SIZE * sizeof(char *));
    q->front = 0;
    q->rear = 0;
    return q;
}

void enqueue(Queue *q, char *word) {
    q->words[q->rear++] = word;
}

char* dequeue(Queue *q) {
    return q->words[q->front++];
}

bool isEmpty(Queue *q) {
    return q->front == q->rear;
}

void freeQueue(Queue *q) {
    free(q->words);
    free(q);
}

bool canTransform(char *word1, char *word2) {
    int diff = 0;
    for (int i = 0; word1[i] != '\0'; i++) {
        if (word1[i] != word2[i]) {
            diff++;
        }
        if (diff > 1) return false;
    }
    return diff == 1;
}

int ladderLength(char *beginWord, char *endWord, char **wordList, int wordListSize) {
    bool *visited = (bool *)calloc(wordListSize, sizeof(bool));
    Queue *q = createQueue();
    enqueue(q, beginWord);

    int level = 1;

    while (!isEmpty(q)) {
        int size = q->rear - q->front;
        for (int i = 0; i < size; i++) {
            char *currentWord = dequeue(q);
            if (strcmp(currentWord, endWord) == 0) {
                freeQueue(q);
                free(visited);
                return level;
            }
            for (int j = 0; j < wordListSize; j++) {
                if (!visited[j] && canTransform(currentWord, wordList[j])) {
                    visited[j] = true;
                    enqueue(q, wordList[j]);
                }
            }
        }
        level++;
    }

    freeQueue(q);
    free(visited);
    return 0;
}