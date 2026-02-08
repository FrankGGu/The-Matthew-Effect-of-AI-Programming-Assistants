#include <stdlib.h>
#include <string.h>

int* parent;
int* max_val_in_comp;
int* count_max_val_in_comp;

int* head;
int* next_edge;
int* to_node;
int edge_idx;

long long total_good_paths;

int find_set(int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find_set(parent[i]);
}

void add_edge(int u, int v) {
    to_node[edge_idx] = v;
    next_edge[edge_idx] = head[u];
    head[u] = edge_idx++;
}

typedef struct {
    int val;
    int idx;
} NodeInfo;

int compareNodeInfo(const void* a, const void* b) {
    return ((NodeInfo*)a)->val - ((NodeInfo*)b)->val;
}

void unite_sets(int u_idx, int v_idx, int current_val_u) {
    int root_u = find_set(u_idx);
    int root_v = find_set(v_idx);

    if (root_u == root_v) {
        return;
    }

    // At this point, it's guaranteed that max_val_in_comp[root_u] == current_val_u.
    // This is because u_idx is the current node being processed from the sorted list,
    // and its value is current_val_u. Due to the processing order and the condition
    // vals[neighbor] <= current_val_u, any component u_idx belongs to must have
    // current_val_u as its maximum value.

    if (max_val_in_comp[root_v] == current_val_u) {
        // If both components have current_val_u as their maximum value,
        // then any path between a node with value current_val_u in root_u's component
        // and a node with value current_val_u in root_v's component will be a good path.
        // The number of such paths is the product of their counts.
        total_good_paths += (long long)count_max_val_in_comp[root_u] * count_max_val_in_comp[root_v];

        // Merge root_v into root_u
        parent[root_v] = root_u;
        count_max_val_in_comp[root_u] += count_max_val_in_comp[root_v];
        // max_val_in_comp[root_u] remains current_val_u
    } else if (max_val_in_comp[root_v] < current_val_u) {
        // If root_v's component has a maximum value less than current_val_u,
        // merge root_v into root_u. No new good paths are formed between nodes
        // of value current_val_u from different components.
        parent[root_v] = root_u;
        // max_val_in_comp[root_u] and count_max_val_in_comp[root_u] remain unchanged
        // as current_val_u is still the maximum value in the merged component.
    }
    // No other case is possible for max_val_in_comp[root_v] relative to current_val_u,
    // because the condition vals[v_idx] <= current_val_u implies that
    // max_val_in_comp[root_v] must also be <= current_val_u.
}

int numberOfGoodPaths(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize) {
    // Allocate memory for DSU arrays
    parent = (int*)malloc(valsSize * sizeof(int));
    max_val_in_comp = (int*)malloc(valsSize * sizeof(int));
    count_max_val_in_comp = (int*)malloc(valsSize * sizeof(int));

    // Allocate memory for adjacency list
    // Max 2 * (N-1) edges for an undirected graph with N nodes
    head = (int*)malloc(valsSize * sizeof(int));
    next_edge = (int*)malloc(2 * edgesSize * sizeof(int));
    to_node = (int*)malloc(2 * edgesSize * sizeof(int));
    edge_idx = 0;

    // Initialize DSU and adjacency list heads
    for (int i = 0; i < valsSize; ++i) {
        parent[i] = i;
        max_val_in_comp[i] = vals[i];
        count_max_val_in_comp[i] = 1;
        head[i] = -1; // Initialize head for adjacency list
    }

    // Build adjacency list from edges
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v);
        add_edge(v, u);
    }

    // Create and sort NodeInfo array based on node values
    NodeInfo* sorted_nodes = (NodeInfo*)malloc(valsSize * sizeof(NodeInfo));
    for (int i = 0; i < valsSize; ++i) {
        sorted_nodes[i].val = vals[i];
        sorted_nodes[i].idx = i;
    }
    qsort(sorted_nodes, valsSize, sizeof(NodeInfo), compareNodeInfo);

    // Initialize total_good_paths. Each single node is a good path.
    total_good_paths = valsSize;

    // Process nodes in increasing order of their values
    for (int i = 0; i < valsSize; ++i) {
        int u_idx = sorted_nodes[i].idx;
        int current_val_u = sorted_nodes[i].val;

        // Iterate through neighbors of u_idx
        for (int e = head[u_idx]; e != -1; e = next_edge[e]) {
            int v_idx = to_node[e];
            // Only consider neighbors with value less than or equal to current_val_u
            // This ensures the "intermediate nodes <= start/end node value" condition.
            if (vals[v_idx] <= current_val_u) {
                unite_sets(u_idx, v_idx, current_val_u);
            }
        }
    }

    // Free allocated memory
    free(parent);
    free(max_val_in_comp);
    free(count_max_val_in_comp);
    free(head);
    free(next_edge);
    free(to_node);
    free(sorted_nodes);

    return (int)total_good_paths;
}