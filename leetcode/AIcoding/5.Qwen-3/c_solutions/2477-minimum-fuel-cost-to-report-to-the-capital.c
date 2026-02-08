#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* neighbors;
    int size;
} Node;

int minFuelCost(int n, int** roads, int roadsSize, int* roadsColSize) {
    Node* graph = (Node*)malloc(n * sizeof(Node));
    for (int i = 0; i < n; i++) {
        graph[i].neighbors = NULL;
        graph[i].size = 0;
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        int* temp = (int*)realloc(graph[u].neighbors, (graph[u].size + 1) * sizeof(int));
        temp[graph[u].size++] = v;
        graph[u].neighbors = temp;

        temp = (int*)realloc(graph[v].neighbors, (graph[v].size + 1) * sizeof(int));
        temp[graph[v].size++] = u;
        graph[v].neighbors = temp;
    }

    int* people = (int*)calloc(n, sizeof(int));
    int totalFuel = 0;

    void dfs(int node, int parent) {
        for (int i = 0; i < graph[node].size; i++) {
            int neighbor = graph[node].neighbors[i];
            if (neighbor != parent) {
                dfs(neighbor, node);
                people[node] += people[neighbor];
            }
        }
        if (node != 0) {
            totalFuel += (people[node] + 1) / 2;
        }
    }

    dfs(0, -1);

    free(people);
    for (int i = 0; i < n; i++) {
        free(graph[i].neighbors);
    }
    free(graph);

    return totalFuel;
}