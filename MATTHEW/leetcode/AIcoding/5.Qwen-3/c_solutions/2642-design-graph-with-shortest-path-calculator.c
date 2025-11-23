#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

typedef struct Graph {
    int num_nodes;
    Edge** adj;
} Graph;

typedef struct ShortestPathCalculator {
    Graph* graph;
} ShortestPathCalculator;

Edge* createEdge(int to, int weight) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = to;
    newEdge->weight = weight;
    newEdge->next = NULL;
    return newEdge;
}

Graph* createGraph(int num_nodes) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->num_nodes = num_nodes;
    graph->adj = (Edge**)malloc(num_nodes * sizeof(Edge*));
    for (int i = 0; i < num_nodes; i++) {
        graph->adj[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int from, int to, int weight) {
    Edge* newEdge = createEdge(to, weight);
    newEdge->next = graph->adj[from];
    graph->adj[from] = newEdge;
}

ShortestPathCalculator* constructor(int num_nodes, int** edges, int edgesSize, int* edgesColSize) {
    ShortestPathCalculator* obj = (ShortestPathCalculator*)malloc(sizeof(ShortestPathCalculator));
    obj->graph = createGraph(num_nodes);
    for (int i = 0; i < edgesSize; i++) {
        int from = edges[i][0];
        int to = edges[i][1];
        int weight = edges[i][2];
        addEdge(obj->graph, from, to, weight);
    }
    return obj;
}

int dijkstra(Graph* graph, int start, int end) {
    int* dist = (int*)malloc(graph->num_nodes * sizeof(int));
    int* visited = (int*)malloc(graph->num_nodes * sizeof(int));
    for (int i = 0; i < graph->num_nodes; i++) {
        dist[i] = INT_MAX;
        visited[i] = 0;
    }
    dist[start] = 0;
    for (int i = 0; i < graph->num_nodes; i++) {
        int u = -1;
        for (int j = 0; j < graph->num_nodes; j++) {
            if (!visited[j] && (u == -1 || dist[j] < dist[u])) {
                u = j;
            }
        }
        if (u == -1 || dist[u] == INT_MAX) break;
        visited[u] = 1;
        Edge* curr = graph->adj[u];
        while (curr) {
            if (dist[curr->to] > dist[u] + curr->weight) {
                dist[curr->to] = dist[u] + curr->weight;
            }
            curr = curr->next;
        }
    }
    int result = dist[end];
    free(dist);
    free(visited);
    return result;
}

int calculateShortestPath(ShortestPathCalculator* obj, int start, int end) {
    return dijkstra(obj->graph, start, end);
}

void destructor(ShortestPathCalculator* obj) {
    for (int i = 0; i < obj->graph->num_nodes; i++) {
        Edge* curr = obj->graph->adj[i];
        while (curr) {
            Edge* next = curr->next;
            free(curr);
            curr = next;
        }
    }
    free(obj->graph->adj);
    free(obj->graph);
    free(obj);
}