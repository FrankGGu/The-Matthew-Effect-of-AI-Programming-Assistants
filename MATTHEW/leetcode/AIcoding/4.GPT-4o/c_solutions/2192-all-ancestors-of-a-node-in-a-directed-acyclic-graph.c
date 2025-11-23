#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} List;

typedef struct {
    List* lists;
    int size;
} Graph;

void dfs(int node, Graph* graph, int* visited, List* result) {
    visited[node] = 1;
    for (int i = 0; i < graph->lists[node].size; i++) {
        int parent = graph->lists[node].data[i];
        if (!visited[parent]) {
            dfs(parent, graph, visited, result);
        }
        result->data[result->size++] = parent;
    }
}

List* getAncestors(int n, int** edges, int edgesSize, int target) {
    Graph graph;
    graph.lists = malloc(n * sizeof(List));
    for (int i = 0; i < n; i++) {
        graph.lists[i].data = malloc(n * sizeof(int));
        graph.lists[i].size = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph.lists[v].data[graph.lists[v].size++] = u;
    }

    List* result = malloc(sizeof(List));
    result->data = malloc(n * sizeof(int));
    result->size = 0;

    int* visited = calloc(n, sizeof(int));
    dfs(target, &graph, visited, result);

    free(visited);
    for (int i = 0; i < n; i++) {
        free(graph.lists[i].data);
    }
    free(graph.lists);

    return result;
}