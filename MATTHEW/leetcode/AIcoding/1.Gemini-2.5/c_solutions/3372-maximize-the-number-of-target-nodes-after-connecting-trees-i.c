#include <stdlib.h>
#include <stdbool.h>

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

typedef struct Graph {
    int numVertices;
    AdjNode** adjLists;
} Graph;

AdjNode* createNode(int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = v;
    newNode->next = NULL;
    return newNode;
}

Graph* createGraph(int vertices) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->numVertices = vertices;
    graph->adjLists = (AdjNode**)malloc(vertices * sizeof(AdjNode*));
    for (int i = 0; i < vertices; i++) {
        graph->adjLists[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int src, int dest) {
    AdjNode* newNode = createNode(dest);
    newNode->next = graph->adjLists[src];
    graph->adjLists[src] = newNode;

    newNode = createNode(src);
    newNode->next = graph->adjLists[dest];
    graph->adjLists[dest] = newNode;
}

void dfs(Graph* graph, int vertex, bool* visited, const bool* is_target, int* current_component_targets) {
    visited[vertex] = true;
    if (is_target[vertex]) {
        (*current_component_targets)++;
    }

    AdjNode* temp = graph->adjLists[vertex];
    while (temp != NULL) {
        int connectedVertex = temp->val;
        if (!visited[connectedVertex]) {
            dfs(graph, connectedVertex, visited, is_target, current_component_targets);
        }
        temp = temp->next;
    }
}

int maximizeTargets(int n, int** edges, int edgesSize, int* edgesColSize, bool* is_target) {
    if (n == 0) {
        return 0;
    }

    Graph* graph = createGraph(n);

    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }

    bool* visited = (bool*)calloc(n, sizeof(bool));
    int total_targets = 0;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            int current_component_targets = 0;
            dfs(graph, i, visited, is_target, &current_component_targets);
            total_targets += current_component_targets;
        }
    }

    free(visited);
    for (int i = 0; i < n; i++) {
        AdjNode* current = graph->adjLists[i];
        while (current != NULL) {
            AdjNode* next = current->next;
            free(current);
            current = next;
        }
    }
    free(graph->adjLists);
    free(graph);

    return total_targets;
}