#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX 10000

typedef struct {
    char *digits;
    int count;
} Queue;

Queue* createQueue() {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->digits = (char *)malloc(MAX * sizeof(char));
    q->count = 0;
    return q;
}

void enqueue(Queue *q, char *digit) {
    strcpy(q->digits + 4 * q->count, digit);
    q->count++;
}

char* dequeue(Queue *q) {
    if (q->count == 0) return NULL;
    char *digit = (char *)malloc(4 * sizeof(char));
    strncpy(digit, q->digits, 4);
    memmove(q->digits, q->digits + 4, 4 * (q->count - 1));
    q->count--;
    return digit;
}

bool visited[MAX];
int bfs(char *target, char **deadends, int deadendsSize) {
    for (int i = 0; i < deadendsSize; i++) {
        if (strcmp(deadends[i], "0000") == 0) return -1;
        visited[atoi(deadends[i])] = true;
    }

    Queue *q = createQueue();
    enqueue(q, "0000");
    visited[0] = true;

    int level = 0;
    while (q->count > 0) {
        int size = q->count;
        for (int i = 0; i < size; i++) {
            char *current = dequeue(q);
            if (strcmp(current, target) == 0) {
                free(current);
                free(q->digits);
                free(q);
                return level;
            }

            for (int j = 0; j < 4; j++) {
                for (int k = -1; k <= 1; k += 2) {
                    char next[5];
                    strcpy(next, current);
                    next[j] = '0' + (10 + (next[j] - '0') + k) % 10;
                    int num = atoi(next);
                    if (!visited[num]) {
                        visited[num] = true;
                        enqueue(q, next);
                    }
                }
            }
            free(current);
        }
        level++;
    }

    free(q->digits);
    free(q);
    return -1;
}

int openLock(char **deadends, int deadendsSize, char *target) {
    return bfs(target, deadends, deadendsSize);
}