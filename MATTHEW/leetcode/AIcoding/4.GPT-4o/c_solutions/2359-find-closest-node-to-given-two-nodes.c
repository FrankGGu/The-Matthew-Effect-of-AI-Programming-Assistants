#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *edges;
    int size;
} Graph;

int dfs(Graph *graph, int node, int *visited, int target, int *closest) {
    if (node == -1 || visited[node]) return -1;
    visited[node] = 1;

    if (node == target) {
        *closest = node;
        return target;
    }

    int nextNode = graph->edges[node];
    int res = dfs(graph, nextNode, visited, target, closest);
    if (res == -1) {
        *closest = node;
    }
    return res;
}

int findClosestNode(Graph *graph, int node1, int node2) {
    int *visited1 = (int *)calloc(graph->size, sizeof(int));
    int *visited2 = (int *)calloc(graph->size, sizeof(int));
    int closest1 = -1, closest2 = -1;

    dfs(graph, node1, visited1, node2, &closest1);
    dfs(graph, node2, visited2, node1, &closest2);

    if (closest1 == -1 && closest2 == -1) {
        free(visited1);
        free(visited2);
        return -1;
    }

    if (closest1 == closest2) {
        free(visited1);
        free(visited2);
        return closest1;
    }

    free(visited1);
    free(visited2);
    return closest1 != -1 ? closest1 : closest2;
}

int closestNode(int* edges, int edgesSize, int node1, int node2) {
    Graph graph;
    graph.edges = edges;
    graph.size = edgesSize;
    return findClosestNode(&graph, node1, node2);
}