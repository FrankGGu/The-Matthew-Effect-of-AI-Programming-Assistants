#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MAX

#define INF INT_MAX

typedef struct AdjNode {
    int dest;
    int weight;
    struct AdjNode* next;
} AdjNode;

typedef struct AdjList {
    AdjNode* head;
} AdjList;

typedef struct Graph {
    int V;
    AdjList* array;
} Graph;

AdjNode* newAdjNode(int dest, int weight) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
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
    AdjNode* newNode = newAdjNode(dest, weight);
    newNode->next = graph->array[src].head;
    graph->array[src].head = newNode;
}

typedef struct MinHeapNode {
    int v; // Vertex number
    int dist; // Distance from source
} MinHeapNode;

typedef struct MinHeap {
    int size; // Current number of heap nodes
    int capacity; // Capacity of min heap
    int *pos; // This is needed for decreaseKey()
    MinHeapNode **array; // Array of MinHeapNode pointers
} MinHeap;

MinHeapNode* newMinHeapNode(int v, int dist) {
    MinHeapNode* minHeapNode = (MinHeapNode*)malloc(sizeof(MinHeapNode));
    minHeapNode->v = v;
    minHeapNode->dist = dist;
    return minHeapNode;
}

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->pos = (int*)malloc(capacity * sizeof(int));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    minHeap->array = (MinHeapNode**)malloc(capacity * sizeof(MinHeapNode*));
    return minHeap;
}

void swapMinHeapNode(MinHeapNode** a, MinHeapNode** b) {
    MinHeapNode* t = *a;
    *a = *b;
    *b = t;
}

void minHeapify(MinHeap* minHeap, int idx) {
    int smallest, left, right;
    smallest = idx;
    left = 2 * idx + 1;
    right = 2 * idx + 2;

    if (left < minHeap->size &&
        minHeap->array[left]->dist < minHeap->array[smallest]->dist)
        smallest = left;

    if (right < minHeap->size &&
        minHeap->array[right]->dist < minHeap->array[smallest]->dist)
        smallest = right;

    if (smallest != idx) {
        // The nodes to be swapped in min heap
        MinHeapNode *smallestNode = minHeap->array[smallest];
        MinHeapNode *idxNode = minHeap->array[idx];

        // Swap positions
        minHeap->pos[smallestNode->v] = idx;
        minHeap->pos[idxNode->v] = smallest;

        // Swap nodes
        swapMinHeapNode(&minHeap->array[smallest], &minHeap->array[idx]);

        minHeapify(minHeap, smallest);
    }
}

int isEmpty(MinHeap* minHeap) {
    return minHeap->size == 0;
}

MinHeapNode* extractMin(MinHeap* minHeap) {
    if (isEmpty(minHeap))
        return NULL;

    // Store the root node
    MinHeapNode* root = minHeap->array[0];

    // Replace root node with last node
    MinHeapNode* lastNode = minHeap->array[minHeap->size - 1];
    minHeap->array[0] = lastNode;

    // Update position of last node
    minHeap->pos[root->v] = minHeap->size - 1; 
    minHeap->pos[lastNode->v] = 0;

    // Reduce heap size and heapify root
    minHeap->size--;
    minHeapify(minHeap, 0);

    return root;
}

void decreaseKey(MinHeap* minHeap, int v, int dist) {
    // Get the index of v in heap array
    int i = minHeap->pos[v];

    // Get the node and update its dist value
    minHeap->array[i]->dist = dist;

    // Travel up while the complete tree is not heapified.
    while (i && minHeap->array[i]->dist < minHeap->array[(i - 1) / 2]->dist) {
        // Swap this node with its parent
        minHeap->pos[minHeap->array[i]->v] = (i - 1) / 2;
        minHeap->pos[minHeap->array[(i - 1) / 2]->v] = i;
        swapMinHeapNode(&minHeap->array[i], &minHeap->array[(i - 1) / 2]);

        // Move to parent index
        i = (i - 1) / 2;
    }
}

int isInMinHeap(MinHeap *minHeap, int v) {
   return minHeap->pos[v] < minHeap->size;
}

int networkDelayTime(int** times, int timesSize, int* timesColSize, int n, int k) {
    int source = k - 1; // Adjust k to be 0-indexed for graph array

    Graph* graph = createGraph(n);
    for (int i = 0; i < timesSize; ++i) {
        int u = times[i][0] - 1; // 0-indexed
        int v = times[i][1] - 1; // 0-indexed
        int w = times[i][2];
        addEdge(graph, u, v, w);
    }

    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        dist[i] = INF;
    }
    dist[source] = 0;

    MinHeap* minHeap = createMinHeap(n);
    for (int v = 0; v < n; ++v) {
        minHeap->array[v] = newMinHeapNode(v, dist[v]);
        minHeap->pos[v] = v;
    }
    minHeap->size = n;

    decreaseKey(minHeap, source, dist[source]);

    while (!isEmpty(minHeap)) {
        MinHeapNode* minHeapNode = extractMin(minHeap);
        int u = minHeapNode->v;
        free(minHeapNode);

        AdjNode* pCrawl = graph->array[u].head;
        while (pCrawl != NULL) {
            int v = pCrawl->dest;
            int weight = pCrawl->weight;

            if (isInMinHeap(minHeap, v) && dist[u] != INF &&
                dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                decreaseKey(minHeap, v, dist[v]);
            }
            pCrawl = pCrawl->next;
        }
    }

    int max_delay = 0;
    for (int i = 0; i < n; ++i) {
        if (dist[i] == INF) {
            max_delay = -1;
            break;
        }
        if (dist[i] > max_delay) {
            max_delay = dist[i];
        }
    }

    for (int i = 0; i < n; ++i) {
        AdjNode* current = graph->array[i].head;
        while (current != NULL) {
            AdjNode* next = current->next;
            free(current);
            current = next;
        }
    }
    free(graph->array);
    free(graph);
    free(dist);
    free(minHeap->array);
    free(minHeap->pos);
    free(minHeap);

    return max_delay;
}