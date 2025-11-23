#include <stdio.h>
#include <stdlib.h>

typedef struct Edge {
    int to;
    struct Edge* next;
} Edge;

typedef struct Graph {
    int numVertices;
    Edge** adj;
} Graph;

Graph* createGraph(int n) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->numVertices = n;
    graph->adj = (Edge**)malloc(n * sizeof(Edge*));
    for (int i = 0; i < n; i++) {
        graph->adj[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int v, int w) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = w;
    newEdge->next = graph->adj[v];
    graph->adj[v] = newEdge;

    newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = v;
    newEdge->next = graph->adj[w];
    graph->adj[w] = newEdge;
}

void dfs(int u, int parent, int* disc, int* low, int* time, Graph* graph, int** result, int* resSize, int** res) {
    disc[u] = low[u] = ++(*time);
    Edge* edge = graph->adj[u];
    while (edge) {
        int v = edge->to;
        if (v == parent) {
            edge = edge->next;
            continue;
        }
        if (disc[v] == -1) {
            dfs(v, u, disc, low, time, graph, result, resSize, res);
            low[u] = (low[u] < low[v]) ? low[u] : low[v];
            if (low[v] > disc[u]) {
                int* conn = (int*)malloc(2 * sizeof(int));
                conn[0] = u;
                conn[1] = v;
                (*res)[*resSize] = conn;
                (*resSize)++;
            }
        } else {
            low[u] = (low[u] < disc[v]) ? low[u] : disc[v];
        }
        edge = edge->next;
    }
}

int** criticalConnections(int n, int** connections, int connectionsSize, int* returnSize) {
    Graph* graph = createGraph(n);
    for (int i = 0; i < connectionsSize; i++) {
        addEdge(graph, connections[i][0], connections[i][1]);
    }

    int* disc = (int*)malloc(n * sizeof(int));
    int* low = (int*)malloc(n * sizeof(int));
    int time = 0;
    int** result = (int**)malloc(connectionsSize * sizeof(int*));
    *returnSize = 0;

    for (int i = 0; i < n; i++) {
        disc[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        if (disc[i] == -1) {
            dfs(i, -1, disc, low, &time, graph, &result, returnSize, &result);
        }
    }

    return result;
}