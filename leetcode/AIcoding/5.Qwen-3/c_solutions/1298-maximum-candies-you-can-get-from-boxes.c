#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* status;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->status = (int*)malloc(capacity * sizeof(int));
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    q->status[q->size++] = value;
}

int dequeue(Queue* q) {
    int val = q->status[0];
    for (int i = 1; i < q->size; i++) {
        q->status[i - 1] = q->status[i];
    }
    q->size--;
    return val;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->status);
    free(q);
}

int maxCandies(int* boxes, int boxesSize, int* keys, int keysSize, int* containedBoxes, int containedBoxesSize, int* boxIsPresent, int boxIsPresentSize) {
    int* hasKey = (int*)calloc(boxesSize, sizeof(int));
    int* receivedBox = (int*)calloc(boxesSize, sizeof(int));
    int* hasBox = (int*)calloc(boxesSize, sizeof(int));
    int* boxStatus = (int*)calloc(boxesSize, sizeof(int));
    int count = 0;

    for (int i = 0; i < boxesSize; i++) {
        hasBox[i] = boxIsPresent[i];
    }

    for (int i = 0; i < keysSize; i++) {
        hasKey[keys[i]] = 1;
    }

    Queue* q = createQueue(boxesSize);

    for (int i = 0; i < boxesSize; i++) {
        if (hasKey[i] && hasBox[i]) {
            enqueue(q, i);
            receivedBox[i] = 1;
        }
    }

    while (!isEmpty(q)) {
        int current = dequeue(q);
        count++;
        for (int i = 0; i < containedBoxesSize; i++) {
            if (containedBoxes[i] == current) {
                int box = boxes[i];
                if (!receivedBox[box]) {
                    receivedBox[box] = 1;
                    if (hasKey[box]) {
                        enqueue(q, box);
                    }
                }
            }
        }
        for (int i = 0; i < boxesSize; i++) {
            if (boxStatus[i] == 0 && hasKey[i] && hasBox[i] && !receivedBox[i]) {
                enqueue(q, i);
                receivedBox[i] = 1;
            }
        }
    }

    free(hasKey);
    free(receivedBox);
    free(hasBox);
    free(boxStatus);
    freeQueue(q);
    return count;
}