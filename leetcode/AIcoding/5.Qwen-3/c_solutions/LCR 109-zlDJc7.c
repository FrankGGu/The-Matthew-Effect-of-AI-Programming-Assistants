#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** data;
    int size;
    int capacity;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (char**)malloc(1000 * sizeof(char*));
    q->size = 0;
    q->capacity = 1000;
    return q;
}

void enqueue(Queue* q, char* s) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (char**)realloc(q->data, q->capacity * sizeof(char*));
    }
    q->data[q->size++] = strdup(s);
}

char* dequeue(Queue* q) {
    char* s = q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
    q->size--;
    return s;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    for (int i = 0; i < q->size; i++) {
        free(q->data[i]);
    }
    free(q->data);
    free(q);
}

typedef struct {
    char** keys;
    int size;
} Set;

Set* createSet() {
    Set* s = (Set*)malloc(sizeof(Set));
    s->keys = (char**)malloc(1000 * sizeof(char*));
    s->size = 0;
    return s;
}

int contains(Set* s, char* key) {
    for (int i = 0; i < s->size; i++) {
        if (strcmp(s->keys[i], key) == 0) {
            return 1;
        }
    }
    return 0;
}

void add(Set* s, char* key) {
    if (!contains(s, key)) {
        s->keys[s->size++] = strdup(key);
    }
}

void freeSet(Set* s) {
    for (int i = 0; i < s->size; i++) {
        free(s->keys[i]);
    }
    free(s->keys);
    free(s);
}

char* nextMove(char* s, int i, int direction) {
    char* newS = (char*)malloc(5 * sizeof(char));
    strcpy(newS, s);
    int digit = newS[i] - '0';
    if (direction == 0) {
        digit = (digit + 1) % 10;
    } else {
        digit = (digit - 1 + 10) % 10;
    }
    newS[i] = '0' + digit;
    return newS;
}

int openLock(char** deadends, int deadendsSize, char* target) {
    char* start = "0000";
    if (strcmp(start, target) == 0) return 0;
    Set* dead = createSet();
    for (int i = 0; i < deadendsSize; i++) {
        add(dead, deadends[i]);
    }
    if (contains(dead, start)) return -1;
    Queue* queue = createQueue();
    enqueue(queue, start);
    Set* visited = createSet();
    add(visited, start);
    int steps = 0;
    while (!isEmpty(queue)) {
        int levelSize = queue->size;
        for (int i = 0; i < levelSize; i++) {
            char* current = dequeue(queue);
            for (int j = 0; j < 4; j++) {
                for (int d = 0; d < 2; d++) {
                    char* next = nextMove(current, j, d);
                    if (strcmp(next, target) == 0) {
                        freeQueue(queue);
                        freeSet(dead);
                        freeSet(visited);
                        free(next);
                        return steps + 1;
                    }
                    if (!contains(dead, next) && !contains(visited, next)) {
                        add(visited, next);
                        enqueue(queue, next);
                    }
                    free(next);
                }
            }
            free(current);
        }
        steps++;
    }
    freeQueue(queue);
    freeSet(dead);
    freeSet(visited);
    return -1;
}