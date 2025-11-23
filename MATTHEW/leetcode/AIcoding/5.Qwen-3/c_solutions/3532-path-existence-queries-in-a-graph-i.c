#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* neighbors;
    int size;
} Node;

bool dfs(int node, int target, bool* visited, Node* graph) {
    if (node == target) return true;
    visited[node] = true;
    for (int i = 0; i < graph[node].size; i++) {
        int neighbor = graph[node].neighbors[i];
        if (!visited[neighbor] && dfs(neighbor, target, visited, graph)) {
            return true;
        }
    }
    return false;
}

bool* checkIfPrerequisite(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    Node* graph = (Node*)malloc(numCourses * sizeof(Node));
    for (int i = 0; i < numCourses; i++) {
        graph[i].neighbors = NULL;
        graph[i].size = 0;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][0];
        int v = prerequisites[i][1];
        int* newNeighbors = (int*)realloc(graph[u].neighbors, (graph[u].size + 1) * sizeof(int));
        newNeighbors[graph[u].size++] = v;
        graph[u].neighbors = newNeighbors;
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        bool* visited = (bool*)calloc(numCourses, sizeof(bool));
        result[i] = dfs(u, v, visited, graph);
        free(visited);
    }

    *returnSize = queriesSize;
    return result;
}