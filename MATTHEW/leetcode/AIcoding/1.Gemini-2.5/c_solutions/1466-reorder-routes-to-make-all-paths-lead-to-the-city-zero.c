#include <stdlib.h> 
#include <stdbool.h> 

typedef struct Edge {
    int to;
    int cost;
    struct Edge* next;
} Edge;

Edge** adj;
bool* visited;
int result_count;

void dfs(int u, int parent) {
    visited[u] = true;
    Edge* current_edge = adj[u];
    while (current_edge != NULL) {
        int v = current_edge->to;
        int cost = current_edge->cost;

        if (v == parent) {
            current_edge = current_edge->next;
            continue;
        }

        if (!visited[v]) {
            result_count += cost;
            dfs(v, u);
        }
        current_edge = current_edge->next;
    }
}

int minReorder(int n, int** connections, int connectionsSize, int* connectionsColSize) {
    adj = (Edge**)calloc(n, sizeof(Edge*));
    visited = (bool*)calloc(n, sizeof(bool));
    result_count = 0;

    for (int i = 0; i < connectionsSize; i++) {
        int u = connections[i][0];
        int v = connections[i][1];

        Edge* new_edge_uv = (Edge*)malloc(sizeof(Edge));
        new_edge_uv->to = v;
        new_edge_uv->cost = 1;
        new_edge_uv->next = adj[u];
        adj[u] = new_edge_uv;

        Edge* new_edge_vu = (Edge*)malloc(sizeof(Edge));
        new_edge_vu->to = u;
        new_edge_vu->cost = 0;
        new_edge_vu->next = adj[v];
        adj[v] = new_edge_vu;
    }

    dfs(0, -1);

    for (int i = 0; i < n; i++) {
        Edge* current = adj[i];
        while (current != NULL) {
            Edge* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);
    free(visited);

    return result_count;
}