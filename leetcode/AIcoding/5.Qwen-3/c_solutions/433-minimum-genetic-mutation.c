#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct QueueNode {
    char *value;
    struct QueueNode *next;
} QueueNode;

typedef struct {
    QueueNode *front;
    QueueNode *rear;
} Queue;

Queue *createQueue() {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    return q;
}

void enqueue(Queue *q, char *value) {
    QueueNode *newNode = (QueueNode *)malloc(sizeof(QueueNode));
    newNode->value = strdup(value);
    newNode->next = NULL;
    if (!q->front) {
        q->front = q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
}

char *dequeue(Queue *q) {
    if (!q->front) return NULL;
    QueueNode *temp = q->front;
    char *value = temp->value;
    q->front = q->front->next;
    if (!q->front) q->rear = NULL;
    free(temp);
    return value;
}

int isEmpty(Queue *q) {
    return q->front == NULL;
}

void freeQueue(Queue *q) {
    while (q->front) {
        QueueNode *temp = q->front;
        q->front = q->front->next;
        free(temp->value);
        free(temp);
    }
    free(q);
}

int minMutation(char *startGene, char *endGene, char **bank, int bankSize) {
    char *allowed = "ACGT";
    Queue *queue = createQueue();
    enqueue(queue, startGene);
    int steps = 0;
    int visited[bankSize];
    for (int i = 0; i < bankSize; i++) visited[i] = 0;

    while (!isEmpty(queue)) {
        int size = 0;
        Queue *nextLevel = createQueue();
        while (!isEmpty(queue)) {
            char *current = dequeue(queue);
            if (strcmp(current, endGene) == 0) {
                freeQueue(queue);
                freeQueue(nextLevel);
                return steps;
            }
            for (int i = 0; i < bankSize; i++) {
                if (!visited[i] && strlen(bank[i]) == strlen(current)) {
                    int diff = 0;
                    for (int j = 0; j < strlen(current); j++) {
                        if (current[j] != bank[i][j]) diff++;
                    }
                    if (diff == 1) {
                        visited[i] = 1;
                        enqueue(nextLevel, bank[i]);
                    }
                }
            }
            free(current);
        }
        queue = nextLevel;
        steps++;
    }
    freeQueue(queue);
    return -1;
}