#include <stdlib.h>
#include <limits.h> // For LLONG_MAX

#define MAX_NODES 100005
#define MAX_EDGES 100005

typedef struct Edge {
    int to;
    int weight;
    int next;
} Edge;

Edge adj_edges[MAX_EDGES];
int adj_head[MAX_NODES];
int adj_edge_count;

Edge rev_adj_edges[MAX_EDGES];
int rev_adj_head[MAX_NODES];
int rev_adj_edge_count;

void init_graph_structures(int n) {
    for (int i = 0; i < n; ++i) {
        adj_head[i] = -1;
        rev_adj_head[i] = -1;
    }
    adj_edge_count = 0;
    rev_adj_edge_count = 0;
}

void add_adj_edge(int u, int v, int w) {
    adj_edges[adj_edge_count].to = v;
    adj_edges[adj_edge_count].weight = w;
    adj_edges[adj_edge_count].next = adj_head[u];
    adj_head[u] = adj_edge_count;
    adj_edge_count++;
}

void add_rev_adj_edge(int u, int v, int w) {
    rev_adj_edges[rev_adj_edge_count].to = v;
    rev_adj_edges[rev_adj_edge_count].weight = w;
    rev_adj_edges[rev_adj_edge_count].next = rev_adj_head[u];
    rev_adj_head[u] = rev_adj_edge_count;
    rev_adj_edge_count++;
}

typedef struct PQNode {
    long long dist;
    int node;
} PQNode;

PQNode pq[MAX_NODES];
int pq_size;

void swap_pq_nodes(int i, int j) {
    PQNode temp = pq[i];
    pq[i] = pq[j];
    pq[j] = temp;
}

void pq_push(long long dist, int node) {
    pq[pq_size].dist = dist;
    pq[pq_size].node = node;
    int current = pq_size;
    pq_size++;

    while (current > 0) {
        int parent = (current - 1) / 2;
        if (pq[current].dist < pq[parent].dist) {
            swap_pq_nodes(current, parent);
            current = parent;
        } else {
            break;
        }
    }
}

PQNode pq_pop() {
    PQNode top = pq[0];
    pq_size--;
    if (pq_size > 0) {
        pq[0] = pq[pq_size];
        int current = 0;
        while (1) {
            int left_child = 2 * current + 1;
            int right_child = 2 * current + 2;
            int smallest = current;

            if (left_child < pq_size && pq[left_child].dist < pq[smallest].dist) {
                smallest = left_child;
            }
            if (right_child < pq_size && pq[right_child].dist < pq[smallest].dist) {
                smallest = right_child;
            }

            if (smallest != current) {
                swap_pq_nodes(current, smallest);
                current = smallest;
            } else {
                break;
            }
        }
    }
    return top;
}

int pq_is_empty() {
    return pq_size == 0;
}

void dijkstra(int n, int start_node, int* head_arr, Edge* edges_arr, long long* dist_arr) {
    for (int i = 0; i < n; ++i) {
        dist_arr[i] = LLONG_MAX;
    }
    dist_arr[start_node] = 0;

    pq_size = 0;
    pq_push(0, start_node);

    while (!pq_is_empty()) {
        PQNode current = pq_pop();
        long long d = current.dist;
        int u = current.node;

        if (d > dist_arr[u]) {
            continue;
        }

        for (int edge_idx = head_arr[u]; edge_idx != -1; edge_idx = edges_arr[edge_idx].next) {
            int v = edges_arr[edge_idx].to;
            int weight = edges_arr[edge_idx].weight;

            if (dist_arr[u] != LLONG_MAX && dist_arr[u] + weight < dist_arr[v]) {
                dist_arr[v] = dist_arr[u] + weight;
                pq_push(dist_arr[v], v);
            }
        }
    }
}

long long minimumWeight(int n, int** edges, int edgesSize, int* edgesColSize, int source1, int source2, int dest) {
    init_graph_structures(n);

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        add_adj_edge(u, v, w);
        add_rev_adj_edge(v, u, w);
    }

    long long* dist1_arr = (long long*)malloc(n * sizeof(long long));
    long long* dist2_arr = (long long*)malloc(n * sizeof(long long));
    long long* dist_rev_dest_arr = (long long*)malloc(n * sizeof(long long));

    dijkstra(n, source1, adj_head, adj_edges, dist1_arr);
    dijkstra(n, source2, adj_head, adj_edges, dist2_arr);
    dijkstra(n, dest, rev_adj_head, rev_adj_edges, dist_rev_dest_arr);

    long long min_total_weight = LLONG_MAX;

    for (int m = 0; m < n; ++m) {
        if (dist1_arr[m] != LLONG_MAX &&
            dist2_arr[m] != LLONG_MAX &&
            dist_rev_dest_arr[m] != LLONG_MAX) {

            long long current_total = dist1_arr[m] + dist2_arr[m] + dist_rev_dest_arr[m];
            if (current_total < min_total_weight) {
                min_total_weight = current_total;
            }
        }
    }

    free(dist1_arr);
    free(dist2_arr);
    free(dist_rev_dest_arr);

    return (min_total_weight == LLONG_MAX) ? -1 : min_total_weight;
}