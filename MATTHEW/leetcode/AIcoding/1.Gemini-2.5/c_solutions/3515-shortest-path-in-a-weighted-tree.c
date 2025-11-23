#include <stdlib.h>
#include <limits.h> // For INT_MAX

typedef struct AdjListNode {
    int dest;
    int weight;
    struct AdjListNode* next;
} AdjListNode;

typedef struct AdjList {
    AdjListNode* head;
} AdjList;

typedef struct Graph {
    int V;
    AdjList* array;
} Graph;

AdjListNode* newAdjListNode(int dest, int weight) {
    AdjListNode* newNode = (AdjListNode*)malloc(sizeof(AdjListNode));
    newNode->dest = dest;
    newNode->weight = weight;
    newNode->next = NULL;
    return newNode;
}

Graph* createGraph(int V) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->V = V;
    graph->array = (AdjList*)malloc(V * sizeof(AdjList));
    for (int i = 0; i < V; ++i) {
        graph->array[i].head = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int src, int dest, int weight) {
    // Add edge from src to dest
    AdjListNode* newNode = newAdjListNode(dest, weight);
    newNode->next = graph->array[src].head;
    graph->array[src].head = newNode;

    // Add edge from dest to src (for undirected graph)
    newNode = newAdjListNode(src, weight);
    newNode->next = graph->array[dest].head;
    graph->array[dest].head = newNode;
}

typedef struct HeapNode {
    int vertex;
    int dist;
} HeapNode;

typedef struct MinHeap {
    int size;     // Current number of heap nodes
    int capacity; // Maximum possible number of heap nodes
    int* pos;     // Used to store position of vertex in min heap
    HeapNode** array;
} MinHeap;

HeapNode* newHeapNode(int vertex, int dist) {
    HeapNode* heapNode = (HeapNode*)malloc(sizeof(HeapNode));
    heapNode->vertex = vertex;
    heapNode->dist = dist;
    return heapNode;
}

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->pos = (int*)malloc(capacity * sizeof(int));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    minHeap->array = (HeapNode**)malloc(capacity * sizeof(HeapNode*));
    return minHeap;
}

void swapHeapNodes(HeapNode** a, HeapNode** b) {
    HeapNode* t = *a;
    *a = *b;
    *b = t;
}

void minHeapify(MinHeap* minHeap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < minHeap->size && minHeap->array[left]->dist < minHeap->array[smallest]->dist) {
        smallest = left;
    }

    if (right < minHeap->size && minHeap->array[right]->dist < minHeap->array[smallest]->dist) {
        smallest = right;
    }

    if (smallest != idx) {
        // Swap nodes in heap array
        HeapNode* smallestNode = minHeap->array[smallest];
        HeapNode* idxNode = minHeap->array[idx];

        // Swap their positions in pos array
        minHeap->pos[smallestNode->vertex] = idx;
        minHeap->pos[idxNode->vertex] = smallest;

        swapHeapNodes(&minHeap->array[smallest], &minHeap->array[idx]);

        minHeapify(minHeap, smallest);
    }
}

int isEmpty(MinHeap* minHeap) {
    return minHeap->size == 0;
}

HeapNode* extractMin(MinHeap* minHeap) {
    if (isEmpty(minHeap)) {
        return NULL;
    }

    // Store the root node
    HeapNode* root = minHeap->array[0];

    // Replace root with last node
    HeapNode* lastNode = minHeap->array[minHeap->size - 1];
    minHeap->array[0] = lastNode;

    // Update position of last node
    minHeap->pos[root->vertex] = minHeap->size - 1;
    minHeap->pos[lastNode->vertex] = 0;

    // Decrease heap size and heapify root
    minHeap->size--;
    minHeapify(minHeap, 0);

    return root;
}

void decreaseKey(MinHeap* minHeap, int vertex, int dist) {
    // Get the index of v in heap array
    int i = minHeap->pos[vertex];

    // Get the node and update its dist value
    minHeap->array[i]->dist = dist;

    // Travel up while the complete tree is not heapified.
    while (i > 0 && minHeap->array[i]->dist < minHeap->array[(i - 1) / 2]->dist) {
        // Swap this node with its parent
        minHeap->pos[minHeap->array[i]->vertex] = (i - 1) / 2;
        minHeap->pos[minHeap->array[(i - 1) / 2]->vertex] = i;
        swapHeapNodes(&minHeap->array[i], &minHeap->array[(i - 1) / 2]);

        // Move to parent index
        i = (i - 1) / 2;
    }
}

int isInMinHeap(MinHeap* minHeap, int vertex) {
    return minHeap->pos[vertex] < minHeap->size;
}

int* shortestPath(int n, int** edges, int edgesSize, int* edgesColSize, int startNode, int* returnSize) {
    Graph* graph = createGraph(n);
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int weight = edges[i][2];
        addEdge(graph, u, v, weight);
    }

    int* dist = (int*)malloc(n * sizeof(int));
    MinHeap* minHeap = createMinHeap(n);

    for (int v = 0; v < n; ++v) {
        dist[v] = INT_MAX;
        minHeap->array[v] = newHeapNode(v, dist[v]);
        minHeap->pos[v] = v;
    }

    dist[startNode] = 0;
    decreaseKey(minHeap, startNode, 0);

    minHeap->size = n;

    while (!isEmpty(minHeap)) {
        HeapNode* heapNode = extractMin(minHeap);
        int u = heapNode->vertex;
        free(heapNode);

        AdjListNode* pCrawl = graph->array[u].head;
        while (pCrawl != NULL) {
            int v = pCrawl->dest;

            if (isInMinHeap(minHeap, v) && dist[u] != INT_MAX &&
                pCrawl->weight + dist[u] < dist[v]) {
                dist[v] = dist[u] + pCrawl->weight;
                decreaseKey(minHeap, v, dist[v]);
            }
            pCrawl = pCrawl->next;
        }
    }

    *returnSize = n;

    for (int i = 0; i < n; ++i) {
        AdjListNode* current = graph->array[i].head;
        while (current != NULL) {
            AdjListNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph->array);
    free(graph);

    free(minHeap->array);
    free(minHeap->pos);
    free(minHeap);

    return dist;
}