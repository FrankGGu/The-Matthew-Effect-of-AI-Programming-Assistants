#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int val;
    struct Node** neighbors;
    int neighborsSize;
} Node;

typedef struct Queue {
    int front, rear;
    int capacity;
    Node** array;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->front = q->rear = -1;
    q->capacity = capacity;
    q->array = (Node**)malloc(capacity * sizeof(Node*));
    return q;
}

int isFull(Queue* q) {
    return (q->rear + 1) % q->capacity == q->front;
}

int isEmpty(Queue* q) {
    return q->front == -1;
}

void enqueue(Queue* q, Node* item) {
    if (isFull(q)) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->array[q->rear] = item;
    if (q->front == -1) q->front = 0;
}

Node* dequeue(Queue* q) {
    if (isEmpty(q)) return NULL;
    Node* item = q->array[q->front];
    if (q->front == q->rear) {
        q->front = q->rear = -1;
    } else {
        q->front = (q->front + 1) % q->capacity;
    }
    return item;
}

Node* cloneGraph(Node* node) {
    if (!node) return NULL;

    Node** map = (Node**)malloc(1000 * sizeof(Node*));
    for (int i = 0; i < 1000; i++) map[i] = NULL;

    Queue* q = createQueue(1000);
    enqueue(q, node);

    Node* root = (Node*)malloc(sizeof(Node));
    root->val = node->val;
    map[node->val] = root;

    while (!isEmpty(q)) {
        Node* current = dequeue(q);
        for (int i = 0; i < current->neighborsSize; i++) {
            Node* neighbor = current->neighbors[i];
            if (!map[neighbor->val]) {
                Node* newNeighbor = (Node*)malloc(sizeof(Node));
                newNeighbor->val = neighbor->val;
                newNeighbor->neighbors = (Node**)malloc(1000 * sizeof(Node*));
                newNeighbor->neighborsSize = 0;
                map[neighbor->val] = newNeighbor;
                enqueue(q, neighbor);
            }
            map[current->val]->neighbors = (Node**)realloc(map[current->val]->neighbors, (map[current->val]->neighborsSize + 1) * sizeof(Node*));
            map[current->val]->neighbors[map[current->val]->neighborsSize++] = map[neighbor->val];
        }
    }

    return root;
}