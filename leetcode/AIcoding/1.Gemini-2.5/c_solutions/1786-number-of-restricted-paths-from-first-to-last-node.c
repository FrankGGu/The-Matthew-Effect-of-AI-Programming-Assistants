#include <stdlib.h>
#include <stdbool.h>
#include <limits.h> // For LLONG_MAX

#define MAX_NODES 20001
#define MAX_EDGES_TOTAL 100001 // Maximum 2 * 50000 edges for undirected graph
#define MOD 1000000007

typedef struct EdgeNode {
    int to;
    int weight;
    int next_edge_idx;
} EdgeNode;

EdgeNode edge_list[MAX_EDGES_TOTAL];
int adj_head[MAX_NODES]; // Stores index of the first edge in edge_list for a node
int edge_count; // Tracks the current number of edges added to edge_list

void add_edge(int u, int v, int weight) {
    edge_list[edge_count].to = v;
    edge_list[edge_count].weight = weight;
    edge_list[edge_count].next_edge_idx = adj_head[u];
    adj_head[u] = edge_count++;
}

typedef struct PQNode {
    long long dist;
    int node;
} PQNode;

PQNode pq_heap[MAX_NODES]; // Stores elements of the heap
int pq_size; // Current number of elements in the heap

void pq_init() {
    pq_size = 0;
}

void pq_push(long long dist, int node) {
    pq_heap[pq_size].dist = dist;
    pq_heap[pq_size].node = node;
    int current = pq_size;
    pq_size++;

    while (current > 0) {
        int parent = (current - 1) / 2;
        if (pq_heap[current].dist < pq_heap[parent].dist) {
            PQNode temp = pq_heap[current];
            pq_heap[current] = pq_heap[parent];
            pq_heap[parent] = temp;
            current = parent;
        } else {
            break;
        }
    }
}

PQNode pq_pop() {
    PQNode min_node = pq_heap[0];
    pq_size--;
    pq_heap[0] = pq_heap[pq_size];

    int current = 0;
    while (true) {
        int left_child = 2 * current + 1;
        int right_child = 2 * current + 2;
        int smallest = current;

        if (left_child < pq_size && pq_heap[left_child].dist < pq_heap[smallest].dist) {
            smallest = left_child;
        }
        if (right_child < pq_size && pq_heap[right_child].dist < pq_heap[smallest].dist) {
            smallest = right_child;
        }

        if (smallest != current) {
            PQNode temp = pq_heap[current];
            pq_heap[current] = pq_heap[smallest];
            pq_heap[smallest] = temp;
            current = smallest;
        } else {
            break;
        }
    }
    return min_node;
}

bool pq_is_empty() {
    return pq_size == 0;
}

long long distances[MAX_NODES];
int dp[MAX_NODES];

typedef struct NodeDist {
    long long dist;
    int node;
} NodeDist;

NodeDist sorted_nodes[MAX_NODES];

int compareNodeDist(const void* a, const void* b) {
    NodeDist* na = (NodeDist*)a;
    NodeDist* nb = (NodeDist*)b;
    if (na->dist < nb->dist) return -1;
    if (na->dist > nb->dist) return 1;
    return 0;
}

int countRestrictedPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    for (int i = 1; i <= n; ++i) {
        adj_head[i] = -1;
    }
    edge_count = 0;

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        add_edge(u, v, w);
        add_edge(v, u, w);
    }

    for (int i = 1; i <= n; ++i) {
        distances[i] = LLONG_MAX;
    }
    distances[n] = 0;

    pq_init();
    pq_push(0, n);

    while (!pq_is_empty()) {
        PQNode current = pq_pop();
        long long d = current.dist;
        int u = current.node;

        if (d > distances[u]) {
            continue;
        }

        for (int i = adj_head[u]; i != -1; i = edge_list[i].next_edge_idx) {
            int v = edge_list[i].to;
            int weight = edge_list[i].weight;
            if (distances[u] != LLONG_MAX && distances[u] + weight < distances[v]) {
                distances[v] = distances[u] + weight;
                pq_push(distances[v], v);
            }
        }
    }

    for (int i = 1; i <= n; ++i) {
        dp[i] = 0;
        sorted_nodes[i-1].dist = distances[i];
        sorted_nodes[i-1].node = i;
    }

    qsort(sorted_nodes, n, sizeof(NodeDist), compareNodeDist);

    dp[n] = 1;

    for (int i = 0; i < n; ++i) {
        int u = sorted_nodes[i].node;

        for (int edge_idx = adj_head[u]; edge_idx != -1; edge_idx = edge_list[edge_idx].next_edge_idx) {
            int v = edge_list[edge_idx].to;
            if (distances[u] > distances[v]) {
                dp[u] = (dp[u] + dp[v]) % MOD;
            }
        }
    }

    return dp[1];
}