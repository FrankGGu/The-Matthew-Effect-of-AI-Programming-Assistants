#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int **adjMatrix;
    int size;
} Graph;

Graph* createGraph(int n) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->size = n;
    graph->adjMatrix = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph->adjMatrix[i] = (int*)calloc(n, sizeof(int));
    }
    return graph;
}

void addEdge(Graph* graph, int u, int v) {
    graph->adjMatrix[u][v] = 1;
    graph->adjMatrix[v][u] = 1;
}

bool dfs(Graph* graph, int current, int target, bool* visited) {
    if (current == target) return true;
    visited[current] = true;

    for (int i = 0; i < graph->size; i++) {
        if (graph->adjMatrix[current][i] == 1 && !visited[i]) {
            if (dfs(graph, i, target, visited)) {
                return true;
            }
        }
    }
    return false;
}

bool validPath(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination) {
    Graph* graph = createGraph(n);
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }

    bool* visited = (bool*)calloc(n, sizeof(bool));
    bool result = dfs(graph, source, destination, visited);

    free(visited);
    for (int i = 0; i < n; i++) {
        free(graph->adjMatrix[i]);
    }
    free(graph->adjMatrix);
    free(graph);

    return result;
}