#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

void addEdge(Edge** adj, int u, int v, int w) {
    Edge* newNode = (Edge*)malloc(sizeof(Edge));
    newNode->to = v;
    newNode->weight = w;
    newNode->next = adj[u];
    adj[u] = newNode;
}

int* shortestPath(int n, int** edges, int edgesSize, int* edgesColSize, int src) {
    Edge** adj = (Edge**)malloc(n * sizeof(Edge*));
    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        addEdge(adj, edges[i][0], edges[i][1], edges[i][2]);
        addEdge(adj, edges[i][1], edges[i][0], edges[i][2]);
    }

    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[src] = 0;

    int* visited = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    for (int count = 0; count < n - 1; count++) {
        int u = -1;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && (u == -1 || (dist[v] != INT_MAX && (dist[u] == INT_MAX || dist[v] < dist[u])))) {
                u = v;
            }
        }

        if (u == -1) break;

        visited[u] = 1;

        Edge* curr = adj[u];
        while (curr != NULL) {
            int v = curr->to;
            int weight = curr->weight;
            if (dist[u] != INT_MAX && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
            }
            curr = curr->next;
        }
    }

    for(int i = 0; i < n; i++) {
        if(dist[i] == INT_MAX) {
            dist[i] = -1;
        }
    }

    for (int i = 0; i < n; i++) {
        Edge* curr = adj[i];
        while (curr != NULL) {
            Edge* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }
    free(adj);
    free(visited);

    return dist;
}