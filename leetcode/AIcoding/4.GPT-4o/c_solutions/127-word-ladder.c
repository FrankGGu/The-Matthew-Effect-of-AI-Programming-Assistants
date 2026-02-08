#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char **words;
    int size;
} WordList;

typedef struct {
    char **queue;
    int front;
    int rear;
} Queue;

Queue* createQueue(int size) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->queue = (char**)malloc(size * sizeof(char*));
    q->front = 0;
    q->rear = 0;
    return q;
}

void enqueue(Queue *q, char *word) {
    q->queue[q->rear++] = word;
}

char* dequeue(Queue *q) {
    return q->queue[q->front++];
}

bool isEnd(char *word, char *endWord) {
    return strcmp(word, endWord) == 0;
}

bool canTransform(char *word1, char *word2) {
    int diff = 0;
    for (int i = 0; word1[i] && word2[i]; i++) {
        if (word1[i] != word2[i]) diff++;
        if (diff > 1) return false;
    }
    return diff == 1;
}

int ladderLength(char *beginWord, char *endWord, char **wordList, int wordListSize) {
    bool *visited = (bool *)calloc(wordListSize, sizeof(bool));
    Queue *q = createQueue(wordListSize + 1);
    enqueue(q, beginWord);
    int level = 1;

    while (q->front < q->rear) {
        int size = q->rear - q->front;
        for (int i = 0; i < size; i++) {
            char *currentWord = dequeue(q);
            if (isEnd(currentWord, endWord)) {
                free(visited);
                free(q->queue);
                free(q);
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
    free(visited);
    free(q->queue);
    free(q);
    return 0;
}