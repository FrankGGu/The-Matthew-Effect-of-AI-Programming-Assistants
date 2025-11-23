#include <stdlib.h>
#include <string.h>
#include <limits.h> // For LLONG_MAX

#define MAX_N 10000

typedef struct Edge {
    int to;
    int subdivisions;
    struct Edge* next;
} Edge;

Edge* adj[MAX_N];

typedef struct PQNode {
    long long moves;
    int node_idx;
} PQNode;

PQNode pq_heap[MAX_N + 1]; // Using 1-based indexing for convenience
int pq_size;

void swap(int i, int j) {
    PQNode temp = pq_heap[i];
    pq_heap[i] = pq_heap[j];
    pq_heap[j] = temp;
}

void heapify_up(int idx) {
    while (idx > 1 && pq_heap[idx].moves < pq_heap[idx / 2].moves) {
        swap(idx, idx / 2);
        idx /= 2;
    }
}

void heapify_down(int idx) {
    int left_child, right_child, smallest;
    while (1) {
        left_child = 2 * idx;
        right_child = 2 * idx + 1;
        smallest = idx;

        if (left_child <= pq_size && pq_heap[left_child].moves < pq_heap[smallest].moves) {
            smallest = left_child;
        }
        if (right_child <= pq_size && pq_heap[right_child].moves < pq_heap[smallest].moves) {
            smallest = right_child;
        }

        if (smallest != idx) {
            swap(idx, smallest);
            idx = smallest;
        } else {
            break;
        }
    }
}

void pq_push(long long moves, int node_idx) {
    pq_size++;
    pq_heap[pq_size] = (PQNode){.moves = moves, .node_idx = node_idx};
    heapify_up(pq_size);
}

PQNode pq_pop() {
    PQNode min_node = pq_heap[1];
    pq_heap[1] = pq_heap[pq_size];
    pq_size--;
    heapify_down(1);
    return min_node;
}

int pq_is_empty() {
    return pq_size == 0;
}

void add_edge(int u, int v, int subdivisions) {
    Edge* new_edge = (Edge*)malloc(sizeof(Edge));
    new_edge->to = v;
    new_edge->subdivisions = subdivisions;
    new_edge->next = adj[u];
    adj[u] = new_edge;
}

long long long_max(long long a, long long b) {
    return a > b ? a : b;
}

long long long_min(long long a, long long b) {
    return a < b ? a : b;
}

int reachableNodes(int** edges, int edgesSize, int* edgesColSize, int n, int maxMoves) {
    // Initialize adjacency list (clear for potential multiple test cases)
    for (int i = 0; i < n; ++i) {
        Edge* current = adj[i];
        while (current != NULL) {
            Edge* temp = current;
            current = current->next;
            free(temp);
        }
        adj[i] = NULL;
    }

    // Build adjacency list (bidirectional)
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int subdivisions = edges[i][2];
        add_edge(u, v, subdivisions);
        add_edge(v, u, subdivisions);
    }

    // Initialize distances
    long long dist[MAX_N];
    for (int i = 0; i < n; ++i) {
        dist[i] = LLONG_MAX;
    }

    // Initialize priority queue
    pq_size = 0;

    dist[0] = 0;
    pq_push(0, 0);

    // Dijkstra's algorithm
    while (!pq_is_empty()) {
        PQNode current = pq_pop();
        long long d = current.moves;
        int u = current.node_idx;

        // If we found a shorter path previously, skip
        if (d > dist[u]) {
            continue;
        }

        Edge* current_edge = adj[u];
        while (current_edge != NULL) {
            int v = current_edge->to;
            int subdivisions = current_edge->subdivisions;

            // Cost to reach v through this edge: current_moves + subdivisions + 1 (for the original edge segment)
            long long new_d = d + subdivisions + 1;

            if (new_d < dist[v]) {
                dist[v] = new_d;
                pq_push(new_d, v);
            }
            current_edge = current_edge->next;
        }
    }

    int ans = 0;

    // Count original nodes reachable
    for (int i = 0; i < n; ++i) {
        if (dist[i] <= maxMoves) {
            ans++;
        }
    }

    // Count subdivided nodes reachable
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int k = edges[i][2]; // subdivisions

        // Calculate remaining moves from u and v
        long long reachable_from_u = long_max(0LL, (long long)maxMoves - dist[u]);
        long long reachable_from_v = long_max(0LL, (long long)maxMoves - dist[v]);

        // Total unique subdivided nodes on this edge is the sum of nodes reachable from both ends,
        // capped by the total number of subdivisions 'k' on the edge.
        ans += long_min((long long)k, reachable_from_u + reachable_from_v);
    }

    // Free memory used by adjacency list (already done at the beginning for robustness)
    // No need to free again here.

    return ans;
}