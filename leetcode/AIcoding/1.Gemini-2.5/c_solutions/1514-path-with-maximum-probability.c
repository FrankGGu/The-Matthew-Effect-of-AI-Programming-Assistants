#include <stdlib.h>
#include <stdbool.h>

typedef struct AdjNode {
    int to;
    double prob;
    struct AdjNode* next;
} AdjNode;

typedef struct PQNode {
    double prob;
    int node_idx;
} PQNode;

typedef struct PriorityQueue {
    PQNode* heap;
    int capacity;
    int size;
} PriorityQueue;

PriorityQueue* createPriorityQueue(int capacity) {
    PriorityQueue* pq = (PriorityQueue*)malloc(sizeof(PriorityQueue));
    pq->heap = (PQNode*)malloc(sizeof(PQNode) * capacity);
    pq->capacity = capacity;
    pq->size = 0;
    return pq;
}

void swap(PQNode* a, PQNode* b) {
    PQNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(PriorityQueue* pq, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && pq->heap[index].prob > pq->heap[parent].prob) {
        swap(&pq->heap[index], &pq->heap[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(PriorityQueue* pq, int index) {
    int largest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < pq->size && pq->heap[left].prob > pq->heap[largest].prob) {
        largest = left;
    }
    if (right < pq->size && pq->heap[right].prob > pq->heap[largest].prob) {
        largest = right;
    }

    if (largest != index) {
        swap(&pq->heap[index], &pq->heap[largest]);
        heapifyDown(pq, largest);
    }
}

void push(PriorityQueue* pq, double prob, int node_idx) {
    if (pq->size == pq->capacity) {
        pq->capacity *= 2;
        pq->heap = (PQNode*)realloc(pq->heap, sizeof(PQNode) * pq->capacity);
    }
    pq->heap[pq->size].prob = prob;
    pq->heap[pq->size].node_idx = node_idx;
    pq->size++;
    heapifyUp(pq, pq->size - 1);
}

PQNode pop(PriorityQueue* pq) {
    PQNode root = pq->heap[0];
    pq->heap[0] = pq->heap[pq->size - 1];
    pq->size--;
    heapifyDown(pq, 0);
    return root;
}

bool isEmpty(PriorityQueue* pq) {
    return pq->size == 0;
}

void freePriorityQueue(PriorityQueue* pq) {
    if (pq) {
        free(pq->heap);
        free(pq);
    }
}

double maxProbability(int n, int** edges, int edgesSize, int* edgesColSize, double* succProb, int start, int end) {
    AdjNode** adj = (AdjNode**)calloc(n, sizeof(AdjNode*));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        double prob = succProb[i];

        AdjNode* newNode1 = (AdjNode*)malloc(sizeof(AdjNode));
        newNode1->to = v;
        newNode1->prob = prob;
        newNode1->next = adj[u];
        adj[u] = newNode1;

        AdjNode* newNode2 = (AdjNode*)malloc(sizeof(AdjNode));
        newNode2->to = u;
        newNode2->prob = prob;
        newNode2->next = adj[v];
        adj[v] = newNode2;
    }

    double* max_prob = (double*)calloc(n, sizeof(double));

    PriorityQueue* pq = createPriorityQueue(n + edgesSize); 

    push(pq, 1.0, start);
    max_prob[start] = 1.0;

    while (!isEmpty(pq)) {
        PQNode current = pop(pq);
        double current_prob = current.prob;
        int u = current.node_idx;

        if (current_prob < max_prob[u]) {
            continue;
        }

        AdjNode* neighbor = adj[u];
        while (neighbor != NULL) {
            int v = neighbor->to;
            double p_uv = neighbor->prob;

            if (max_prob[u] * p_uv > max_prob[v]) {
                max_prob[v] = max_prob[u] * p_uv;
                push(pq, max_prob[v], v);
            }
            neighbor = neighbor->next;
        }
    }

    double result = max_prob[end];

    freePriorityQueue(pq);
    free(max_prob);
    for (int i = 0; i < n; i++) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);

    return result;
}