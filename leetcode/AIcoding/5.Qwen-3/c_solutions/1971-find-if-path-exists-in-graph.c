#include <stdio.h>
#include <stdlib.h>

bool hasPath(int n, int** graph, int start, int end, bool* visited) {
    if (start == end) return true;
    visited[start] = true;
    for (int i = 0; i < graph[start]; i++) {
        int neighbor = graph[start][i];
        if (!visited[neighbor] && hasPath(n, graph, neighbor, end, visited)) {
            return true;
        }
    }
    return false;
}

bool validPath(int n, int** graph, int graphSize, int* graphEdges, int start, int end) {
    bool* visited = (bool*)malloc(n * sizeof(bool));
    for (int i = 0; i < n; i++) visited[i] = false;
    bool result = hasPath(n, graph, start, end, visited);
    free(visited);
    return result;
}