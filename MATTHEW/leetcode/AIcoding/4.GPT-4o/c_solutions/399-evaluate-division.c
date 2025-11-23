#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *u;
    char *v;
    double val;
} Edge;

typedef struct {
    Edge *edges;
    int edgeCount;
} Graph;

double dfs(Graph *graph, int *visited, char *start, char *end, double acc) {
    if (strcmp(start, end) == 0) return acc;

    for (int i = 0; i < graph->edgeCount; i++) {
        if (strcmp(graph->edges[i].u, start) == 0 && !visited[i]) {
            visited[i] = 1;
            double res = dfs(graph, visited, graph->edges[i].v, end, acc * graph->edges[i].val);
            if (res != -1) return res;
            visited[i] = 0;
        }
        if (strcmp(graph->edges[i].v, start) == 0 && !visited[i]) {
            visited[i] = 1;
            double res = dfs(graph, visited, graph->edges[i].u, end, acc / graph->edges[i].val);
            if (res != -1) return res;
            visited[i] = 0;
        }
    }
    return -1;
}

double* calcEquation(char*** equations, double* values, int equationsSize, char*** queries, int queriesSize, double* returnSize) {
    Graph graph;
    graph.edges = (Edge *)malloc(equationsSize * sizeof(Edge));
    graph.edgeCount = equationsSize;

    for (int i = 0; i < equationsSize; i++) {
        graph.edges[i].u = equations[i][0];
        graph.edges[i].v = equations[i][1];
        graph.edges[i].val = values[i];
    }

    double *result = (double *)malloc(queriesSize * sizeof(double));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int *visited = (int *)calloc(equationsSize, sizeof(int));
        result[i] = dfs(&graph, visited, queries[i][0], queries[i][1], 1.0);
        free(visited);
    }

    free(graph.edges);
    return result;
}