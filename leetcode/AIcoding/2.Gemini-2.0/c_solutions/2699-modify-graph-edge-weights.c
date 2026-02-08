#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int to;
    int weight;
    int index;
} Edge;

typedef struct Graph {
    int n;
    Edge **adj;
    int *adj_size;
} Graph;

Graph* createGraph(int n) {
    Graph *graph = (Graph*)malloc(sizeof(Graph));
    graph->n = n;
    graph->adj = (Edge**)malloc(n * sizeof(Edge*));
    graph->adj_size = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        graph->adj[i] = (Edge*)malloc(n * sizeof(Edge));
    }
    return graph;
}

void addEdge(Graph *graph, int u, int v, int weight, int index) {
    graph->adj[u][graph->adj_size[u]].to = v;
    graph->adj[u][graph->adj_size[u]].weight = weight;
    graph->adj[u][graph->adj_size[u]].index = index;
    graph->adj_size[u]++;
}

int* dijkstra(Graph *graph, int start, int n) {
    int *dist = (int*)malloc(n * sizeof(int));
    int *visited = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[start] = 0;

    for (int count = 0; count < n - 1; count++) {
        int u = -1;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && (u == -1 || dist[v] < dist[u])) {
                u = v;
            }
        }

        if (u == -1) break;
        visited[u] = 1;

        for (int i = 0; i < graph->adj_size[u]; i++) {
            int v = graph->adj[u][i].to;
            int weight = graph->adj[u][i].weight;

            if (dist[u] != INT_MAX && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
            }
        }
    }

    free(visited);
    return dist;
}

int* modifyGraphEdgeWeights(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination, int target) {
    Graph *graph = createGraph(n);
    int unknown_count = 0;
    int *result = (int*)malloc(edgesSize * sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int weight = edges[i][2];

        if (weight == -1) {
            unknown_count++;
            result[i] = -1;
        } else {
            result[i] = weight;
        }

        addEdge(graph, u, v, weight, i);
        addEdge(graph, v, u, weight, i);
    }

    int *dist_original = dijkstra(graph, source, n);
    int diff = target - dist_original[destination];

    free(dist_original);

    if (diff < 0 && unknown_count > 0) {
        return NULL;
    }

    int current_diff = 0;
    for (int i = 0; i < edgesSize; i++) {
        if (result[i] == -1) {
            int u = edges[i][0];
            int v = edges[i][1];

            graph->adj[u][0].weight = 1;
            graph->adj[v][0].weight = 1;

            for(int j = 0; j < graph->adj_size[u]; j++){
                if(graph->adj[u][j].to == v){
                    graph->adj[u][j].weight = 1;
                    break;
                }
            }
            for(int j = 0; j < graph->adj_size[v]; j++){
                if(graph->adj[v][j].to == u){
                    graph->adj[v][j].weight = 1;
                    break;
                }
            }

            result[i] = 1;
        }
    }

    int *dist = dijkstra(graph, source, n);
    int actual_diff = target - dist[destination];

    free(dist);

    if(actual_diff < 0){
        return NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][2] == -1) {
            int u = edges[i][0];
            int v = edges[i][1];

            graph->adj[u][0].weight = actual_diff + 1;
            graph->adj[v][0].weight = actual_diff + 1;

            for(int j = 0; j < graph->adj_size[u]; j++){
                if(graph->adj[u][j].to == v){
                    graph->adj[u][j].weight = actual_diff + 1;
                    break;
                }
            }
            for(int j = 0; j < graph->adj_size[v]; j++){
                if(graph->adj[v][j].to == u){
                    graph->adj[v][j].weight = actual_diff + 1;
                    break;
                }
            }

            result[i] = actual_diff + 1;
        }
    }

    int *final_dist = dijkstra(graph, source, n);
    if (final_dist[destination] != target) {
        free(final_dist);
        return NULL;
    }
    free(final_dist);

    return result;
}