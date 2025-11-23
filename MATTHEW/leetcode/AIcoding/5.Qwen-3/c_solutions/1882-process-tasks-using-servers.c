#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int index;
    int time;
} Server;

typedef struct {
    int* data;
    int size;
    int capacity;
} PriorityQueue;

void swap(Server* a, Server* b) {
    Server t = *a;
    *a = *b;
    *b = t;
}

int compare(const void* a, const void* b) {
    Server* s1 = (Server*)a;
    Server* s2 = (Server*)b;
    if (s1->time != s2->time) {
        return s1->time - s2->time;
    }
    return s1->index - s2->index;
}

void heapify(Server* heap, int n, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < n && (heap[left].time < heap[smallest].time || 
                      (heap[left].time == heap[smallest].time && heap[left].index < heap[smallest].index))) {
        smallest = left;
    }

    if (right < n && (heap[right].time < heap[smallest].time || 
                       (heap[right].time == heap[smallest].time && heap[right].index < heap[smallest].index))) {
        smallest = right;
    }

    if (smallest != i) {
        swap(&heap[i], &heap[smallest]);
        heapify(heap, n, smallest);
    }
}

void push(PriorityQueue* pq, Server server) {
    if (pq->size == pq->capacity) {
        pq->capacity *= 2;
        pq->data = (int*)realloc(pq->data, pq->capacity * sizeof(int));
    }
    pq->data[pq->size++] = server.index;
    qsort(pq->data, pq->size, sizeof(Server), compare);
}

Server pop(PriorityQueue* pq) {
    Server server = {pq->data[0], 0};
    pq->data[0] = pq->data[--pq->size];
    heapify((Server*)pq->data, pq->size, 0);
    return server;
}

int* assignTasks(int* servers, int serversSize, int* tasks, int tasksSize, int* returnSize) {
    int* result = (int*)malloc(tasksSize * sizeof(int));
    *returnSize = tasksSize;

    Server* available = (Server*)malloc(serversSize * sizeof(Server));
    for (int i = 0; i < serversSize; i++) {
        available[i] = (Server){i, 0};
    }

    PriorityQueue pq;
    pq.data = (int*)malloc(serversSize * sizeof(int));
    pq.size = 0;
    pq.capacity = serversSize;

    for (int i = 0; i < serversSize; i++) {
        push(&pq, available[i]);
    }

    int time = 0;
    int taskIndex = 0;

    while (taskIndex < tasksSize) {
        while (taskIndex < tasksSize && tasks[taskIndex] <= time) {
            Server server = pop(&pq);
            result[taskIndex] = server.index;
            server.time = time + tasks[taskIndex];
            push(&pq, server);
            taskIndex++;
        }

        if (pq.size == 0) {
            time = tasks[taskIndex];
        } else {
            time++;
        }
    }

    free(available);
    free(pq.data);
    return result;
}