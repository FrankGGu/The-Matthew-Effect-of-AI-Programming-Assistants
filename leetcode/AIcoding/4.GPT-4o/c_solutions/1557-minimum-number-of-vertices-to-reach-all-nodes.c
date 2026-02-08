#include <stdbool.h>
#include <stdlib.h>

struct Graph {
    int numVertices;
    int** adjList;
};

struct Graph* createGraph(int n) {
    struct Graph* graph = (struct Graph*)malloc(sizeof(struct Graph));
    graph->numVertices = n;
    graph->adjList = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph->adjList[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph->adjList[i][j] = 0;
        }
    }
    return graph;
}

void addEdge(struct Graph* graph, int src, int dest) {
    graph->adjList[src][dest] = 1;
}

int* findSmallestSetOfVertices(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = 0;
    for (int i = 0; i < edgesSize; i++) {
        n = n > edges[i][0] ? n : edges[i][0] + 1;
        n = n > edges[i][1] ? n : edges[i][1] + 1;
    }

    int* indegree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        indegree[edges[i][1]]++;
    }

    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            result[(*returnSize)++] = i;
        }
    }

    free(indegree);
    return result;
}