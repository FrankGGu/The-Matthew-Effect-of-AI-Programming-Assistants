#include <stdbool.h>
#include <string.h> // For memset, if needed, but manual loop is fine for init

#define MAX_NODES 200005
#define MAX_EDGES_ADJ_LIST 400005 // 2 * MAX_EDGES (2 * 200000)

int head[MAX_NODES];
int next_edge[MAX_EDGES_ADJ_LIST];
int to_node[MAX_EDGES_ADJ_LIST];
int edge_idx;

bool visited[MAX_NODES];
int queue[MAX_NODES];
int q_front, q_rear;

void add_edge(int u, int v) {
    to_node[edge_idx] = v;
    next_edge[edge_idx] = head[u];
    head[u] = edge_idx;
    edge_idx++;
}

void init_graph_and_visited(int n) {
    for (int i = 0; i < n; i++) {
        head[i] = -1;
        visited[i] = false;
    }
    edge_idx = 0;
}

void init_queue() {
    q_front = 0;
    q_rear = 0;
}

void enqueue(int node) {
    queue[q_rear++] = node;
}

int dequeue() {
    return queue[q_front++];
}

bool is_queue_empty() {
    return q_front == q_rear;
}

bool validPath(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination) {
    if (source == destination) {
        return true;
    }

    init_graph_and_visited(n);

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v);
        add_edge(v, u);
    }

    init_queue();
    enqueue(source);
    visited[source] = true;

    while (!is_queue_empty()) {
        int u = dequeue();

        if (u == destination) {
            return true;
        }

        for (int i = head[u]; i != -1; i = next_edge[i]) {
            int v = to_node[i];
            if (!visited[v]) {
                visited[v] = true;
                enqueue(v);
            }
        }
    }

    return false;
}