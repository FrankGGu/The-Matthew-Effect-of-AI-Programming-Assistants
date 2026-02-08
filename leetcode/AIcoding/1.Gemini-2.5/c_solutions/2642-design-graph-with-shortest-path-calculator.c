#include <stdlib.h>
#include <limits.h>

typedef struct Edge {
    int to;
    int cost;
    struct Edge* next;
} Edge;

typedef struct {
    int n;
    Edge** adj;
} Graph;

Graph* graphCreate(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->n = n;
    graph->adj = (Edge**)calloc(n, sizeof(Edge*));

    for (int i = 0; i < edgesSize; i++) {
        int from = edges[i][0];
        int to = edges[i][1];
        int cost = edges[i][2];

        Edge* newEdge = (Edge*)malloc(sizeof(Edge));
        newEdge->to = to;
        newEdge->cost = cost;
        newEdge->next = graph->adj[from];
        graph->adj[from] = newEdge;
    }

    return graph;
}

void graphAddEdge(Graph* graph, int* edge) {
    int from = edge[0];
    int to = edge[1];
    int cost = edge[2];

    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = to;
    newEdge->cost = cost;
    newEdge->next = graph->adj[from];
    graph->adj[from] = newEdge;
}

int graphShortestPath(Graph* graph, int node1, int node2) {
    if (node1 == node2) {
        return 0;
    }

    int* dist = (int*)malloc(graph->n * sizeof(int));
    int* visited = (int*)calloc(graph->n, sizeof(int));

    for (int i = 0; i < graph->n; i++) {
        dist[i] = INT_MAX;
    }
    dist[node1] = 0;

    for (int i = 0; i < graph->n; i++) {
        int u = -1;
        int minDist = INT_MAX;

        for (int v = 0; v < graph->n; v++) {
            if (!visited[v] && dist[v] < minDist) {
                minDist = dist[v];
                u = v;
            }
        }

        if (u == -1) {
            break;
        }

        visited[u] = 1;

        if (u == node2) {
            int result = dist[node2];
            free(dist);
            free(visited);
            return result;
        }

        Edge* currentEdge = graph->adj[u];
        while (currentEdge != NULL) {
            int v = currentEdge->to;
            int weight = currentEdge->cost;
            if (!visited[v] && dist[u] != INT_MAX && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
            }
            currentEdge = currentEdge->next;
        }
    }

    int result = (dist[node2] == INT_MAX) ? -1 : dist[node2];
    free(dist);
    free(visited);
    return result;
}

void graphFree(Graph* graph) {
    if (graph == NULL) {
        return;
    }

    for (int i = 0; i < graph->n; i++) {
        Edge* current = graph->adj[i];
        while (current != NULL) {
            Edge* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph->adj);
    free(graph);
}