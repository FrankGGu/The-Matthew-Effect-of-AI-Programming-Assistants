#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    char* word;
    int level;
} QueueNode;

typedef struct {
    QueueNode* data;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (QueueNode*)malloc(capacity * sizeof(QueueNode));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, char* word, int level) {
    q->rear++;
    q->data[q->rear].word = strdup(word);
    q->data[q->rear].level = level;
    q->size++;
}

QueueNode dequeue(Queue* q) {
    QueueNode node = q->data[q->front];
    q->front++;
    q->size--;
    return node;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    for (int i = 0; i <= q->rear; i++) {
        free(q->data[i].word);
    }
    free(q->data);
    free(q);
}

int ladderLength(char* beginWord, char* endWord, char** wordList, int wordListSize) {
    int len = strlen(beginWord);
    int* visited = (int*)calloc(wordListSize, sizeof(int));
    Queue* q = createQueue(wordListSize + 1);
    enqueue(q, beginWord, 1);

    while (!isEmpty(q)) {
        QueueNode current = dequeue(q);
        char* word = current.word;
        int level = current.level;

        if (strcmp(word, endWord) == 0) {
            free(word);
            free(visited);
            freeQueue(q);
            return level;
        }

        for (int i = 0; i < wordListSize; i++) {
            if (!visited[i] && strcmp(word, wordList[i]) != 0) {
                int diff = 0;
                for (int j = 0; j < len; j++) {
                    if (word[j] != wordList[i][j]) {
                        diff++;
                    }
                }
                if (diff == 1) {
                    visited[i] = 1;
                    enqueue(q, wordList[i], level + 1);
                }
            }
        }

        free(word);
    }

    free(visited);
    freeQueue(q);
    return 0;
}