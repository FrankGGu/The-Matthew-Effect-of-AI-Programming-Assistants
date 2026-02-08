#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>

typedef struct {
    long long dist;
    int node;
    int k_minus_ones; // Number of -1 edges on path, treated as 1
} PQNode;

#define MAX_PQ_SIZE (100 * 100 + 5)
PQNode pq_heap[MAX_PQ_SIZE];
int pq_size = 0;

void swap(PQNode* a, PQNode* b) {
    PQNode temp = *a;
    *a = *b;
    *b = temp;
}

void push(PQNode node) {
    if (pq_size >= MAX_PQ_SIZE) {
        return;
    }
    pq_heap[pq_size] = node;
    int current = pq_size;
    pq_size++;
    while (current > 0 && pq_heap[current].dist < pq_heap[(current - 1) / 2].dist) {
        swap(&pq_heap[current], &pq_heap[(current - 1) / 2]);
        current = (current - 1) / 2;
    }
}

PQNode pop() {
    PQNode root = pq_heap[0];
    pq_size--;
    if (pq_size > 0) {
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
                swap(&pq_heap[current], &pq_heap[smallest]);
                current = smallest;
            } else {
                break;
            }
        }
    }
    return root;
}

bool is_pq_empty() {
    return pq_size == 0;
}

typedef struct AdjNode {
    int neighbor;
    int edge_idx;
    struct AdjNode* next;
} AdjNode;

AdjNode* adj[100]; // Max N = 100

void add_edge_to_adj(int u, int v, int edge_idx) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->neighbor = v;
    newNode->edge_idx = edge_idx;
    newNode->next = adj[u];
    adj[u] = newNode;
}

typedef struct {
    int prev_node;
    int prev_k;
    int edge_idx;
} ParentInfo;

ParentInfo parent[100][101]; // [node][k_minus_ones]

long long d[100][101]; // [node][k_minus_ones]

long long dijkstra_final(int n, int source, int destination, int** current_edges) {
    long long final_dist[100];
    for (int i = 0; i < n; ++i) {
        final_dist[i] = LLONG_MAX;
    }
    final_dist[source] = 0;

    pq_size = 0; // Reset priority queue
    push((PQNode){0, source, 0}); // k_minus_ones is not used in final Dijkstra

    while (!is_pq_empty()) {
        PQNode current = pop();
        long long dist_u = current.dist;
        int u = current.node;

        if (dist_u > final_dist[u]) {
            continue;
        }
        if (u == destination) {
            return dist_u;
        }

        AdjNode* current_adj_node = adj[u];
        while (current_adj_node != NULL) {
            int v = current_adj_node->neighbor;
            int edge_idx = current_adj_node->edge_idx;
            long long weight = current_edges[edge_idx][2];

            if (final_dist[u] != LLONG_MAX && final_dist[u] + weight < final_dist[v]) {
                final_dist[v] = final_dist[u] + weight;
                push((PQNode){final_dist[v], v, 0});
            }
            current_adj_node = current_adj_node->next;
        }
    }
    return final_dist[destination];
}

int** modifyGraphEdgeWeights(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination, int target, int* returnSize) {
    for (int i = 0; i < n; ++i) {
        adj[i] = NULL;
    }

    for (int i = 0; i < edgesSize; ++i) {
        add_edge_to_adj(edges[i][0], edges[i][1], i);
        add_edge_to_adj(edges[i][1], edges[i][0], i);
    }

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j <= n; ++j) {
            d[i][j] = LLONG_MAX;
            parent[i][j] = (ParentInfo){-1, -1, -1};
        }
    }

    d[source][0] = 0;
    pq_size = 0;
    push((PQNode){0, source, 0});

    while (!is_pq_empty()) {
        PQNode current = pop();
        long long dist_u = current.dist;
        int u = current.node;
        int k_u = current.k_minus_ones;

        if (dist_u > d[u][k_u]) {
            continue;
        }

        AdjNode* current_adj_node = adj[u];
        while (current_adj_node != NULL) {
            int v = current_adj_node->neighbor;
            int edge_idx = current_adj_node->edge_idx;
            long long weight = edges[edge_idx][2];

            int new_k = k_u;
            long long edge_cost = weight;

            if (weight == -1) {
                new_k++;
                edge_cost = 1;
            }

            if (new_k <= n && d[u][k_u] != LLONG_MAX && d[u][k_u] + edge_cost < d[v][new_k]) {
                d[v][new_k] = d[u][k_u] + edge_cost;
                parent[v][new_k] = (ParentInfo){u, k_u, edge_idx};
                push((PQNode){d[v][new_k], v, new_k});
            }
            current_adj_node = current_adj_node->next;
        }
    }

    int best_k = -1;
    long long max_dist_le_target = -1LL;

    for (int k = 0; k <= n; ++k) {
        if (d[destination][k] != LLONG_MAX && d[destination][k] <= target) {
            if (d[destination][k] > max_dist_le_target) {
                max_dist_le_target = d[destination][k];
                best_k = k;
            } else if (d[destination][k] == max_dist_le_target && k < best_k) {
                best_k = k;
            }
        }
    }

    if (best_k == -1) {
        *returnSize = edgesSize;
        for (int i = 0; i < n; ++i) {
            AdjNode* node = adj[i];
            while (node != NULL) {
                AdjNode* temp = node;
                node = node->next;
                free(temp);
            }
        }
        return edges;
    }

    long long remaining_diff = target - max_dist_le_target;

    if (remaining_diff > 0 && best_k == 0) {
        *returnSize = edgesSize;
        for (int i = 0; i < n; ++i) {
            AdjNode* node = adj[i];
            while (node != NULL) {
                AdjNode* temp = node;
                node = node->next;
                free(temp);
            }
        }
        return edges;
    }

    int** result_edges = (int**)malloc(edgesSize * sizeof(int*));
    for (int i = 0; i < edgesSize; ++i) {
        result_edges[i] = (int*)malloc(3 * sizeof(int));
        result_edges[i][0] = edges[i][0];
        result_edges[i][1] = edges[i][1];
        result_edges[i][2] = edges[i][2];
    }

    bool found_one_to_increase = false;
    int curr_u = destination;
    int curr_k = best_k;

    while (curr_u != source || curr_k != 0) {
        ParentInfo p_info = parent[curr_u][curr_k];
        int prev_u = p_info.prev_node;
        int prev_k = p_info.prev_k;
        int edge_idx = p_info.edge_idx;

        if (edges[edge_idx][2] == -1) {
            if (remaining_diff > 0 && !found_one_to_increase) {
                result_edges[edge_idx][2] = 1 + remaining_diff;
                remaining_diff = 0;
                found_one_to_increase = true;
            } else {
                result_edges[edge_idx][2] = 1;
            }
        }

        curr_u = prev_u;
        curr_k = prev_k;
    }

    for (int i = 0; i < edgesSize; ++i) {
        if (result_edges[i][2] == -1) {
            result_edges[i][2] = 1;
        }
    }

    long long final_shortest_path = dijkstra_final(n, source, destination, result_edges);

    for (int i = 0; i < n; ++i) {
        AdjNode* node = adj[i];
        while (node != NULL) {
            AdjNode* temp = node;
            node = node->next;
            free(temp);
        }
    }

    if (final_shortest_path == target) {
        *returnSize = edgesSize;
        return result_edges;
    } else {
        for (int i = 0; i < edgesSize; ++i) {
            free(result_edges[i]);
        }
        free(result_edges);
        *returnSize = edgesSize;
        return edges;
    }
}