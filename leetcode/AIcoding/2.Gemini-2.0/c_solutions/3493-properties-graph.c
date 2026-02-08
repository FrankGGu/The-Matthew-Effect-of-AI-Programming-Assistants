#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Graph {
    int V;
    int E;
    int** adj;
};

struct Graph* createGraph(int V) {
    struct Graph* graph = (struct Graph*)malloc(sizeof(struct Graph));
    graph->V = V;
    graph->E = 0;
    graph->adj = (int**)malloc(V * sizeof(int*));
    for (int i = 0; i < V; i++) {
        graph->adj[i] = (int*)malloc(V * sizeof(int));
        for (int j = 0; j < V; j++) {
            graph->adj[i][j] = 0;
        }
    }
    return graph;
}

void addEdge(struct Graph* graph, int u, int v) {
    graph->adj[u][v] = 1;
    graph->adj[v][u] = 1;
    graph->E++;
}

bool isCyclicUtil(struct Graph* graph, int v, bool visited[], int parent) {
    visited[v] = true;
    for (int i = 0; i < graph->V; i++) {
        if (graph->adj[v][i]) {
            if (!visited[i]) {
                if (isCyclicUtil(graph, i, visited, v))
                    return true;
            } else if (i != parent) {
                return true;
            }
        }
    }
    return false;
}

bool isCyclic(struct Graph* graph) {
    bool* visited = (bool*)malloc(graph->V * sizeof(bool));
    for (int i = 0; i < graph->V; i++)
        visited[i] = false;

    for (int i = 0; i < graph->V; i++) {
        if (!visited[i]) {
            if (isCyclicUtil(graph, i, visited, -1))
                return true;
        }
    }
    free(visited);
    return false;
}

bool isConnected(struct Graph* graph) {
    bool* visited = (bool*)malloc(graph->V * sizeof(bool));
    for (int i = 0; i < graph->V; i++)
        visited[i] = false;

    int startNode = 0;
    for(int i = 0; i < graph->V; i++){
        bool has_edge = false;
        for(int j = 0; j < graph->V; j++){
            if(graph->adj[i][j] == 1){
                has_edge = true;
                break;
            }
        }
        if(has_edge){
            startNode = i;
            break;
        }
    }

    void DFS(struct Graph* graph, int v, bool visited[]) {
        visited[v] = true;
        for (int i = 0; i < graph->V; i++) {
            if (graph->adj[v][i] && !visited[i]) {
                DFS(graph, i, visited);
            }
        }
    }

    DFS(graph, startNode, visited);

    for (int i = 0; i < graph->V; i++) {
        bool has_edge = false;
        for(int j = 0; j < graph->V; j++){
            if(graph->adj[i][j] == 1){
                has_edge = true;
                break;
            }
        }
        if(has_edge && !visited[i]) {
            free(visited);
            return false;
        }
    }

    free(visited);
    return true;
}

bool* solve(int n, int** edges, int edgesSize, int* edgesColSize){
    struct Graph* graph = createGraph(n);
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }

    bool* result = (bool*)malloc(2 * sizeof(bool));
    result[0] = isCyclic(graph);
    result[1] = isConnected(graph);

    for(int i = 0; i < n; i++){
        free(graph->adj[i]);
    }
    free(graph->adj);
    free(graph);

    return result;
}