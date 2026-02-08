#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge *next;
} Edge;

void addEdge(Edge **adj, int u, int v, int w) {
    Edge *newEdge = (Edge *)malloc(sizeof(Edge));
    newEdge->to = v;
    newEdge->weight = w;
    newEdge->next = adj[u];
    adj[u] = newEdge;
}

int dfs(int u, int parent, int signalStrength, int distance, Edge **adj) {
    int count = 0;
    if (distance % signalStrength == 0 && distance > 0) {
        count++;
    }

    for (Edge *edge = adj[u]; edge != NULL; edge = edge->next) {
        int v = edge->to;
        int weight = edge->weight;
        if (v != parent) {
            count += dfs(v, u, signalStrength, distance + weight, adj);
        }
    }

    return count;
}

int *countPairsOfConnectableServers(int n, int edges[][3], int edgesSize, int signalStrength) {
    Edge **adj = (Edge **)malloc(n * sizeof(Edge *));
    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        addEdge(adj, u, v, w);
        addEdge(adj, v, u, w);
    }

    int *result = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        int total = 0;
        int neighbors = 0;
        for (Edge *edge = adj[i]; edge != NULL; edge = edge->next) {
            neighbors++;
        }
        for (Edge *edge = adj[i]; edge != NULL; edge = edge->next) {
            int v = edge->to;
            int weight = edge->weight;
            int count = dfs(v, i, signalStrength, weight, adj);
            total += count;
        }

        result[i] = total;
        Edge **tempAdj = (Edge **)malloc(n * sizeof(Edge *));
        for (int j = 0; j < n; j++){
            tempAdj[j] = NULL;
        }
        for (int j = 0; j < edgesSize; j++) {
            int u = edges[j][0];
            int v = edges[j][1];
            int w = edges[j][2];
            addEdge(tempAdj, u, v, w);
            addEdge(tempAdj, v, u, w);
        }

        int count = 0;
        for(Edge* edge = adj[i]; edge != NULL; edge = edge->next){

            int num = dfs(edge->to, i, signalStrength, edge->weight, adj);
            result[i] -= num;
            count += num;
        }
        result[i] = (total - count);

        for (int j = 0; j < n; j++){
            Edge *current = adj[j];
            while(current != NULL){
                Edge *temp = current;
                current = current->next;
                free(temp);
            }
            adj[j] = NULL;
        }

        for (int j = 0; j < edgesSize; j++) {
            int u = edges[j][0];
            int v = edges[j][1];
            int w = edges[j][2];
            addEdge(adj, u, v, w);
            addEdge(adj, v, u, w);
        }
    }

    return result;
}