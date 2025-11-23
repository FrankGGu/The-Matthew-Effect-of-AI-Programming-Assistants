#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int node;
    int score;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} Graph;

Graph* createGraph(int capacity) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->size = 0;
    graph->capacity = capacity;
    graph->edges = (Edge*)malloc(capacity * sizeof(Edge));
    return graph;
}

void addEdge(Graph* graph, int node, int score) {
    if (graph->size < graph->capacity) {
        graph->edges[graph->size].node = node;
        graph->edges[graph->size].score = score;
        graph->size++;
    }
}

int minScore(int n, int** roads, int roadsSize, int* roadsColSize) {
    Graph* graph = createGraph(roadsSize * 2);
    int* visited = (int*)calloc(n + 1, sizeof(int));
    int minScore = INT_MAX;

    for (int i = 0; i < roadsSize; i++) {
        addEdge(graph, roads[i][1], roads[i][2]);
        addEdge(graph, roads[i][0], roads[i][2]);
    }

    int* queue = (int*)malloc((n + 1) * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = 1;
    visited[1] = 1;

    while (front < rear) {
        int current = queue[front++];
        for (int i = 0; i < graph->size; i++) {
            if (graph->edges[i].node == current && !visited[roads[i][0]]) {
                visited[roads[i][0]] = 1;
                minScore = (minScore < graph->edges[i].score) ? minScore : graph->edges[i].score;
                queue[rear++] = roads[i][0];
            }
        }
    }

    free(graph->edges);
    free(graph);
    free(visited);
    free(queue);

    return minScore == INT_MAX ? 0 : minScore;
}