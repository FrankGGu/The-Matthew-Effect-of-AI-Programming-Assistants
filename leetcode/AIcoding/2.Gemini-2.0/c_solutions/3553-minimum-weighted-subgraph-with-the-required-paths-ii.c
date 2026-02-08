#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef long long ll;

typedef struct Edge {
    int to;
    int weight;
} Edge;

typedef struct Node {
    int vertex;
    ll distance;
} Node;

typedef struct PriorityQueue {
    Node* array;
    int capacity;
    int size;
} PriorityQueue;

PriorityQueue* createPriorityQueue(int capacity) {
    PriorityQueue* pq = (PriorityQueue*)malloc(sizeof(PriorityQueue));
    pq->capacity = capacity;
    pq->size = 0;
    pq->array = (Node*)malloc(capacity * sizeof(Node));
    return pq;
}

void swap(Node* a, Node* b) {
    Node t = *a;
    *a = *b;
    *b = t;
}

void minHeapify(PriorityQueue* pq, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < pq->size && pq->array[left].distance < pq->array[smallest].distance)
        smallest = left;

    if (right < pq->size && pq->array[right].distance < pq->array[smallest].distance)
        smallest = right;

    if (smallest != i) {
        swap(&pq->array[i], &pq->array[smallest]);
        minHeapify(pq, smallest);
    }
}

void insert(PriorityQueue* pq, int vertex, ll distance) {
    if (pq->size == pq->capacity) {
        return;
    }

    int i = pq->size;
    pq->array[i].vertex = vertex;
    pq->array[i].distance = distance;
    pq->size++;

    while (i != 0 && pq->array[(i - 1) / 2].distance > pq->array[i].distance) {
        swap(&pq->array[i], &pq->array[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int isEmpty(PriorityQueue* pq) {
    return pq->size == 0;
}

Node extractMin(PriorityQueue* pq) {
    if (isEmpty(pq)) {
        Node emptyNode;
        emptyNode.vertex = -1;
        emptyNode.distance = LLONG_MAX;
        return emptyNode;
    }

    Node root = pq->array[0];
    pq->array[0] = pq->array[pq->size - 1];
    pq->size--;
    minHeapify(pq, 0);

    return root;
}

void freePriorityQueue(PriorityQueue* pq) {
    free(pq->array);
    free(pq);
}

long long minimumWeight(int n, int** edges, int edgesSize, int* edgesColSize, int src1, int src2, int dest) {
    Edge* adj[n];
    Edge* revAdj[n];
    int adjSize[n];
    int revAdjSize[n];

    for (int i = 0; i < n; i++) {
        adjSize[i] = 0;
        revAdjSize[i] = 0;
        adj[i] = (Edge*)malloc(edgesSize * sizeof(Edge));
        revAdj[i] = (Edge*)malloc(edgesSize * sizeof(Edge));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        adj[u][adjSize[u]].to = v;
        adj[u][adjSize[u]].weight = w;
        adjSize[u]++;

        revAdj[v][revAdjSize[v]].to = u;
        revAdj[v][revAdjSize[v]].weight = w;
        revAdjSize[v]++;
    }

    ll dist1[n];
    ll dist2[n];
    ll distDest[n];

    for (int i = 0; i < n; i++) {
        dist1[i] = LLONG_MAX;
        dist2[i] = LLONG_MAX;
        distDest[i] = LLONG_MAX;
    }

    PriorityQueue* pq1 = createPriorityQueue(n);
    dist1[src1] = 0;
    insert(pq1, src1, 0);

    while (!isEmpty(pq1)) {
        Node uNode = extractMin(pq1);
        int u = uNode.vertex;
        ll distU = uNode.distance;

        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i].to;
            int weight = adj[u][i].weight;

            if (dist1[v] > distU + weight) {
                dist1[v] = distU + weight;
                insert(pq1, v, dist1[v]);
            }
        }
    }
    freePriorityQueue(pq1);

    PriorityQueue* pq2 = createPriorityQueue(n);
    dist2[src2] = 0;
    insert(pq2, src2, 0);

    while (!isEmpty(pq2)) {
        Node uNode = extractMin(pq2);
        int u = uNode.vertex;
        ll distU = uNode.distance;

        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i].to;
            int weight = adj[u][i].weight;

            if (dist2[v] > distU + weight) {
                dist2[v] = distU + weight;
                insert(pq2, v, dist2[v]);
            }
        }
    }
    freePriorityQueue(pq2);

    PriorityQueue* pqDest = createPriorityQueue(n);
    distDest[dest] = 0;
    insert(pqDest, dest, 0);

    while (!isEmpty(pqDest)) {
        Node uNode = extractMin(pqDest);
        int u = uNode.vertex;
        ll distU = uNode.distance;

        for (int i = 0; i < revAdjSize[u]; i++) {
            int v = revAdj[u][i].to;
            int weight = revAdj[u][i].weight;

            if (distDest[v] > distU + weight) {
                distDest[v] = distU + weight;
                insert(pqDest, v, distDest[v]);
            }
        }
    }
    freePriorityQueue(pqDest);

    ll minWeight = LLONG_MAX;
    for (int i = 0; i < n; i++) {
        if (dist1[i] != LLONG_MAX && dist2[i] != LLONG_MAX && distDest[i] != LLONG_MAX) {
            minWeight = fmin(minWeight, dist1[i] + dist2[i] + distDest[i]);
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
        free(revAdj[i]);
    }

    return (minWeight == LLONG_MAX) ? -1 : minWeight;
}