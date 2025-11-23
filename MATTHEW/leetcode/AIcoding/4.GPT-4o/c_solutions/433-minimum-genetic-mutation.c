#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *gene;
    int step;
} QueueNode;

typedef struct {
    QueueNode *nodes;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue *queue = (Queue *)malloc(sizeof(Queue));
    queue->nodes = (QueueNode *)malloc(capacity * sizeof(QueueNode));
    queue->front = 0;
    queue->rear = -1;
    queue->size = 0;
    return queue;
}

int isEmpty(Queue *queue) {
    return queue->size == 0;
}

void enqueue(Queue *queue, char *gene, int step) {
    queue->rear = (queue->rear + 1) % (queue->size + 1);
    queue->nodes[queue->rear].gene = gene;
    queue->nodes[queue->rear].step = step;
    queue->size++;
}

QueueNode dequeue(Queue *queue) {
    QueueNode node = queue->nodes[queue->front];
    queue->front = (queue->front + 1) % (queue->size + 1);
    queue->size--;
    return node;
}

void freeQueue(Queue *queue) {
    free(queue->nodes);
    free(queue);
}

int minMutation(char *start, char *end, char **bank, int bankSize) {
    char *geneChars = "ACGT";
    int found = 0;
    int steps = 0;
    int visited[bankSize];
    memset(visited, 0, sizeof(visited));

    Queue *queue = createQueue(bankSize);
    enqueue(queue, start, steps);

    while (!isEmpty(queue)) {
        int levelSize = queue->size;
        for (int i = 0; i < levelSize; i++) {
            QueueNode current = dequeue(queue);
            char *currentGene = current.gene;
            steps = current.step;

            if (strcmp(currentGene, end) == 0) {
                freeQueue(queue);
                return steps;
            }

            for (int j = 0; j < bankSize; j++) {
                if (!visited[j]) {
                    int diff = 0;
                    for (int k = 0; k < 8; k++) {
                        if (currentGene[k] != bank[j][k]) {
                            diff++;
                        }
                    }
                    if (diff == 1) {
                        visited[j] = 1;
                        enqueue(queue, bank[j], steps + 1);
                    }
                }
            }
        }
    }
    freeQueue(queue);
    return -1;
}