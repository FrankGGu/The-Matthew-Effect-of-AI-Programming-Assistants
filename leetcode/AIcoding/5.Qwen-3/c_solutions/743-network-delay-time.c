#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

typedef struct Graph {
    int numVertices;
    Edge** adjList;
} Graph;

Graph* createGraph(int numVertices) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->numVertices = numVertices;
    graph->adjList = (Edge**)malloc(numVertices * sizeof(Edge*));
    for (int i = 0; i < numVertices; i++) {
        graph->adjList[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int from, int to, int weight) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = to;
    newEdge->weight = weight;
    newEdge->next = graph->adjList[from];
    graph->adjList[from] = newEdge;
}

int minDistance(int dist[], int visited[], int numVertices) {
    int min = INT_MAX, minIndex;
    for (int v = 0; v < numVertices; v++) {
        if (!visited[v] && dist[v] <= min) {
            min = dist[v];
            minIndex = v;
        }
    }
    return minIndex;
}

int dijkstra(Graph* graph, int start, int end) {
    int numVertices = graph->numVertices;
    int* dist = (int*)malloc(numVertices * sizeof(int));
    int* visited = (int*)malloc(numVertices * sizeof(int));

    for (int i = 0; i < numVertices; i++) {
        dist[i] = INT_MAX;
        visited[i] = 0;
    }

    dist[start] = 0;

    for (int count = 0; count < numVertices - 1; count++) {
        int u = minDistance(dist, visited, numVertices);
        if (u == -1) break;
        visited[u] = 1;

        Edge* current = graph->adjList[u];
        while (current != NULL) {
            int v = current->to;
            if (!visited[v] && dist[u] + current->weight < dist[v]) {
                dist[v] = dist[u] + current->weight;
            }
            current = current->next;
        }
    }

    int result = dist[end];
    free(dist);
    free(visited);
    return result;
}

int networkDelayTime(int** times, int timesSize, int* timesColSize, int N, int K) {
    Graph* graph = createGraph(N);
    for (int i = 0; i < timesSize; i++) {
        int from = times[i][0] - 1;
        int to = times[i][1] - 1;
        int weight = times[i][2];
        addEdge(graph, from, to, weight);
    }

    int result = dijkstra(graph, K - 1, N - 1);

    // Free graph memory
    for (int i = 0; i < N; i++) {
        Edge* current = graph->adjList[i];
        while (current != NULL) {
            Edge* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph->adjList);
    free(graph);

    return result;
}