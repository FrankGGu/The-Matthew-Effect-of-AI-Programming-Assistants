#include <stdlib.h>
#include <string.h>

typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} AdjList;

void dfs(int node, int parent, int currentWeight, int* maxWeight, AdjList* graph, int* visited, int start, int* hasCycle, int* maxCycleWeight) {
    visited[node] = 1;

    for (int i = 0; i < graph[node].size; i++) {
        int neighbor = graph[node].edges[i].node;
        int weight = graph[node].edges[i].weight;

        if (neighbor == parent) continue;

        if (neighbor == start) {
            *hasCycle = 1;
            if (currentWeight + weight > *maxCycleWeight) {
                *maxCycleWeight = currentWeight + weight;
            }
            continue;
        }

        if (!visited[neighbor]) {
            dfs(neighbor, node, currentWeight + weight, maxWeight, graph, visited, start, hasCycle, maxCycleWeight);
        }
    }

    if (currentWeight > *maxWeight) {
        *maxWeight = currentWeight;
    }
}

int findLongestCycle(int n, int* edges, int edgesSize, int* weight, int weightSize) {
    AdjList* graph = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        graph[i].edges = (Edge*)malloc(4 * sizeof(Edge));
        graph[i].size = 0;
        graph[i].capacity = 4;
    }

    for (int i = 0; i < edgesSize; i += 2) {
        int u = edges[i];
        int v = edges[i + 1];
        int w = weight[i / 2];

        if (graph[u].size == graph[u].capacity) {
            graph[u].capacity *= 2;
            graph[u].edges = (Edge*)realloc(graph[u].edges, graph[u].capacity * sizeof(Edge));
        }
        graph[u].edges[graph[u].size].node = v;
        graph[u].edges[graph[u].size].weight = w;
        graph[u].size++;

        if (graph[v].size == graph[v].capacity) {
            graph[v].capacity *= 2;
            graph[v].edges = (Edge*)realloc(graph[v].edges, graph[v].capacity * sizeof(Edge));
        }
        graph[v].edges[graph[v].size].node = u;
        graph[v].edges[graph[v].size].weight = w;
        graph[v].size++;
    }

    int* visited = (int*)malloc(n * sizeof(int));
    int maxSpecialPath = -1;

    for (int i = 0; i < n; i++) {
        memset(visited, 0, n * sizeof(int));
        int maxWeight = 0;
        int hasCycle = 0;
        int maxCycleWeight = 0;

        dfs(i, -1, 0, &maxWeight, graph, visited, i, &hasCycle, &maxCycleWeight);

        if (hasCycle) {
            if (maxCycleWeight > maxSpecialPath) {
                maxSpecialPath = maxCycleWeight;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i].edges);
    }
    free(graph);
    free(visited);

    return maxSpecialPath;
}