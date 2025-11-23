#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* next;
    int size;
} Graph;

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(int node, int parent, int* visited, Graph* graph, int* result) {
    visited[node] = 1;
    int maxDepth = 0;
    for (int i = 0; i < graph->size; i++) {
        if (graph->next[i] == node && i != parent) {
            int depth = dfs(i, node, visited, graph, result);
            maxDepth = max(maxDepth, depth);
        }
    }
    *result = max(*result, maxDepth + 1);
    return maxDepth + 1;
}

int countCycle(int node, int parent, int* visited, Graph* graph, int* cycleLength) {
    visited[node] = 1;
    for (int i = 0; i < graph->size; i++) {
        if (graph->next[i] == node && i != parent) {
            if (visited[i] == 1) {
                *cycleLength = 1;
                return 1;
            } else if (visited[i] == 0) {
                int res = countCycle(i, node, visited, graph, cycleLength);
                if (res > 0) {
                    *cycleLength += res;
                    return *cycleLength;
                }
            }
        }
    }
    return 0;
}

int maxEmployees(int** relations, int relationsSize, int* relationsColSize) {
    int n = relationsSize;
    int* next = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        next[i] = relations[i][1];
    }
    Graph graph;
    graph.next = next;
    graph.size = n;

    int* visited = (int*)calloc(n, sizeof(int));
    int result = 0;

    for (int i = 0; i < n; i++) {
        if (visited[i] == 0) {
            int cycleLength = 0;
            int res = countCycle(i, -1, visited, &graph, &cycleLength);
            if (res > 0) {
                result += cycleLength;
            } else {
                int depth = dfs(i, -1, visited, &graph, &result);
            }
        }
    }

    free(visited);
    free(next);
    return result;
}