#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Graph {
    int **adjMatrix;
    int *visited;
    int size;
};

struct Graph* createGraph(int size) {
    struct Graph* graph = (struct Graph*)malloc(sizeof(struct Graph));
    graph->size = size;
    graph->adjMatrix = (int**)malloc(size * sizeof(int*));
    graph->visited = (int*)calloc(size, sizeof(int));
    for (int i = 0; i < size; i++) {
        graph->adjMatrix[i] = (int*)malloc(size * sizeof(int));
        memset(graph->adjMatrix[i], -1, size * sizeof(int));
    }
    return graph;
}

void addEdge(struct Graph* graph, int src, int dest, double weight) {
    graph->adjMatrix[src][dest] = weight;
    graph->adjMatrix[dest][src] = 1.0 / weight;
}

double dfs(struct Graph* graph, int start, int end, double* result) {
    if (start == end) return 1.0;
    graph->visited[start] = 1;
    for (int i = 0; i < graph->size; i++) {
        if (graph->adjMatrix[start][i] != -1 && !graph->visited[i]) {
            double temp = dfs(graph, i, end, result);
            if (temp != 0) {
                *result = temp * graph->adjMatrix[start][i];
                return *result;
            }
        }
    }
    return 0;
}

double* calcEquation(char*** equations, double* values, int valuesSize, char*** queries, int queriesSize, int* returnSize) {
    int n = 0;
    for (int i = 0; i < valuesSize; i++) {
        n++;
    }
    struct Graph* graph = createGraph(n);
    for (int i = 0; i < valuesSize; i++) {
        int src = equations[i][0][0] - 'a';
        int dest = equations[i][1][0] - 'a';
        addEdge(graph, src, dest, values[i]);
    }

    double* results = (double*)malloc(queriesSize * sizeof(double));
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; i++) {
        graph->visited = (int*)calloc(n, sizeof(int));
        double result = 0;
        int start = queries[i][0][0] - 'a';
        int end = queries[i][1][0] - 'a';
        if (graph->adjMatrix[start][end] != -1) {
            results[i] = graph->adjMatrix[start][end];
        } else {
            double temp = dfs(graph, start, end, &result);
            results[i] = temp ? result : -1.0;
        }
    }
    return results;
}