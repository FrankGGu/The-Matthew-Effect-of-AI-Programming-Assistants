#include <stdlib.h> // For malloc, free, qsort
#include <limits.h> // For LLONG_MIN

int compareDescending(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

typedef struct {
    int* data;
    int size;
    int capacity;
} AdjList;

void initAdjList(AdjList* list, int initialCapacity) {
    list->data = (int*)malloc(sizeof(int) * initialCapacity);
    list->size = 0;
    list->capacity = initialCapacity;
}

void addAdj(AdjList* list, int val) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->data = (int*)realloc(list->data, sizeof(int) * list->capacity);
    }
    list->data[list->size++] = val;
}

void freeAdjList(AdjList* list) {
    free(list->data);
}

long long maxStarSum(int n, int** edges, int edgesSize, int* edgesColSize, int* vals, int valsSize, int k) {
    // Allocate array of AdjList structures for all nodes
    AdjList* adj = (AdjList*)malloc(sizeof(AdjList) * n);
    for (int i = 0; i < n; ++i) {
        initAdjList(&adj[i], 4); // Initial capacity of 4 for each node's adjacency list
    }

    // Build the adjacency list from edges
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        addAdj(&adj[u], v);
        addAdj(&adj[v], u);
    }

    long long maxSum = LLONG_MIN; // Initialize with smallest possible long long value

    // The maximum star sum must be at least the value of any single node.
    // This handles cases like k=0, no edges, or all neighbors having negative values.
    // If n=0, this would be an issue, but constraints typically guarantee n >= 1.
    for (int i = 0; i < n; ++i) {
        if (vals[i] > maxSum) {
            maxSum = vals[i];
        }
    }

    // Iterate through each node, considering it as the center of a star
    for (int i = 0; i < n; ++i) {
        long long currentSum = vals[i];

        // Temporary array to store positive neighbor values
        // Max possible size is adj[i].size (degree of node i)
        int* neighborVals = (int*)malloc(sizeof(int) * adj[i].size);
        int positiveNeighborCount = 0;

        // Collect positive neighbor values
        for (int j = 0; j < adj[i].size; ++j) {
            int neighborNode = adj[i].data[j];
            if (vals[neighborNode] > 0) {
                neighborVals[positiveNeighborCount++] = vals[neighborNode];
            }
        }

        // Sort positive neighbor values in descending order
        if (positiveNeighborCount > 0) {
            qsort(neighborVals, positiveNeighborCount, sizeof(int), compareDescending);
        }

        // Add up to k largest positive neighbor values to the current sum
        int count = 0;
        for (int j = 0; j < positiveNeighborCount && count < k; ++j) {
            currentSum += neighborVals[j];
            count++;
        }

        // Update the overall maximum star sum
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }

        free(neighborVals); // Free temporary array
    }

    // Free all allocated memory for the adjacency list
    for (int i = 0; i < n; ++i) {
        freeAdjList(&adj[i]);
    }
    free(adj);

    return maxSum;
}