#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(capacity * sizeof(int));
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    q->data[q->size++] = value;
}

int dequeue(Queue* q) {
    int val = q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
    q->size--;
    return val;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int canWin(int n, int x, int y) {
    if (x == y) return 0;
    if (x > y) {
        int temp = x;
        x = y;
        y = temp;
    }

    int* visited = (int*)malloc((n + 1) * sizeof(int));
    memset(visited, 0, (n + 1) * sizeof(int));

    Queue* q = createQueue(n + 1);
    enqueue(q, x);
    visited[x] = 1;

    while (!isEmpty(q)) {
        int current = dequeue(q);
        if (current == y) {
            freeQueue(q);
            free(visited);
            return 1;
        }
        int next = current + 1;
        if (next <= n && !visited[next]) {
            visited[next] = 1;
            enqueue(q, next);
        }
        next = current * 2;
        if (next <= n && !visited[next]) {
            visited[next] = 1;
            enqueue(q, next);
        }
    }

    freeQueue(q);
    free(visited);
    return 0;
}

int findTheWinner(int n, int k) {
    int* people = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        people[i] = i + 1;
    }

    int current = 0;
    while (n > 1) {
        current = (current + k - 1) % n;
        memmove(people + current, people + current + 1, (n - current - 1) * sizeof(int));
        n--;
    }

    int result = people[0];
    free(people);
    return result;
}

int numberOfWays(int n, int x, int y) {
    if (canWin(n, x, y)) {
        return findTheWinner(n, 2);
    } else {
        return 0;
    }
}