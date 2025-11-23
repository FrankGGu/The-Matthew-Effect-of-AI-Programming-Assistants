#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *data;
    int size;
    int capacity;
} Stack;

void initStack(Stack *stack) {
    stack->size = 0;
    stack->capacity = 10;
    stack->data = (int *)malloc(stack->capacity * sizeof(int));
}

void push(Stack *stack, int value) {
    if (stack->size >= stack->capacity) {
        stack->capacity *= 2;
        stack->data = (int *)realloc(stack->data, stack->capacity * sizeof(int));
    }
    stack->data[stack->size++] = value;
}

int pop(Stack *stack) {
    return stack->data[--stack->size];
}

int isEmpty(Stack *stack) {
    return stack->size == 0;
}

void freeStack(Stack *stack) {
    free(stack->data);
}

typedef struct {
    int **adj;
    int *visited;
    int visitedSize;
} Graph;

Graph* createGraph(int n) {
    Graph *graph = (Graph *)malloc(sizeof(Graph));
    graph->adj = (int **)malloc(n * sizeof(int *));
    graph->visited = (int *)calloc(n, sizeof(int));
    graph->visitedSize = 0;
    for (int i = 0; i < n; i++) {
        graph->adj[i] = (int *)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph->adj[i][j] = -1;
        }
    }
    return graph;
}

void addEdge(Graph *graph, int u, int v) {
    graph->adj[u][v] = 1;
    graph->adj[v][u] = 1;
}

void dfs(Graph *graph, int node) {
    graph->visited[node] = 1;
    graph->visitedSize++;
    for (int i = 0; i < graph->visitedSize; i++) {
        if (graph->adj[node][i] == 1 && !graph->visited[i]) {
            dfs(graph, i);
        }
    }
}

int reachableNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* restricted, int restrictedSize) {
    Graph *graph = createGraph(n);
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }
    for (int i = 0; i < restrictedSize; i++) {
        graph->visited[restricted[i]] = 1;
    }
    dfs(graph, 0);
    int result = graph->visitedSize;
    free(graph->visited);
    for (int i = 0; i < n; i++) {
        free(graph->adj[i]);
    }
    free(graph->adj);
    free(graph);
    return result;
}