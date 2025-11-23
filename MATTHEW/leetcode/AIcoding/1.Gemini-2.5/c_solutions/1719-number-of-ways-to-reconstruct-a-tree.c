#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

typedef struct {
    bool nodes[501]; // nodes[i] is true if i is in the set
    int count;       // number of elements in the set
} IntSet;

void init_int_set(IntSet* set) {
    memset(set->nodes, 0, sizeof(bool) * 501);
    set->count = 0;
}

void add_to_int_set(IntSet* set, int val) {
    if (val >= 1 && val <= 500 && !set->nodes[val]) {
        set->nodes[val] = true;
        set->count++;
    }
}

bool is_proper_subset(IntSet* set1, IntSet* set2) {
    if (set1->count >= set2->count) {
        return false; // Not a proper subset if counts are equal or set1 is larger
    }
    for (int i = 1; i <= 500; ++i) {
        if (set1->nodes[i] && !set2->nodes[i]) {
            return false; // set1 contains an element not in set2
        }
    }
    return true;
}

int numberOfWaysToReconstructATree(int** pairs, int pairsSize, int* pairsColSize) {
    // Use an array of IntSet to store adjacency sets for each node.
    IntSet adj_sets[501];
    int unique_nodes_arr[501]; // To store unique node IDs
    int unique_nodes_count = 0;
    bool node_exists[501] = {false}; // To track unique nodes

    for (int i = 1; i <= 500; ++i) {
        init_int_set(&adj_sets[i]);
    }

    // Build adjacency sets and collect unique nodes
    for (int i = 0; i < pairsSize; ++i) {
        int u = pairs[i][0];
        int v = pairs[i][1];

        add_to_int_set(&adj_sets[u], v);
        add_to_int_set(&adj_sets[v], u);

        if (!node_exists[u]) {
            node_exists[u] = true;
            unique_nodes_arr[unique_nodes_count++] = u;
        }
        if (!node_exists[v]) {
            node_exists[v] = true;
            unique_nodes_arr[unique_nodes_count++] = v;
        }
    }

    // Add self-loops to adjacency sets (each node is considered connected to itself)
    for (int i = 0; i < unique_nodes_count; ++i) {
        add_to_int_set(&adj_sets[unique_nodes_arr[i]], unique_nodes_arr[i]);
    }

    if (unique_nodes_count == 0) {
        return 0; // No nodes, no tree.
    }
    // According to constraints, pairsSize >= 1 and ui != vi, so unique_nodes_count >= 2.
    // The case unique_nodes_count == 1 is not reachable.

    // Find the root node
    // The root node must have its adjacency set containing all unique nodes.
    int root_node = -1;
    for (int i = 0; i < unique_nodes_count; ++i) {
        int u = unique_nodes_arr[i];
        if (adj_sets[u].count == unique_nodes_count) {
            root_node = u;
            break;
        }
    }

    if (root_node == -1) {
        return 0; // No node connects to all other nodes (including itself)
    }

    int num_ways = 1;
    int num_edges = 0;

    // For each non-root node, find its parent
    for (int i = 0; i < unique_nodes_count; ++i) {
        int u = unique_nodes_arr[i];
        if (u == root_node) {
            continue;
        }

        int parent_candidate = -1;
        int min_parent_set_size = 502; // Larger than max possible node count + 1

        for (int j = 0; j < unique_nodes_count; ++j) {
            int v = unique_nodes_arr[j];
            if (v == u) {
                continue;
            }

            // A node v is a parent candidate for u if adj_sets[u] is a proper subset of adj_sets[v]
            // AND adj_sets[v] is minimal among such candidates.
            if (is_proper_subset(&adj_sets[u], &adj_sets[v])) {
                if (adj_sets[v].count < min_parent_set_size) {
                    min_parent_set_size = adj_sets[v].count;
                    parent_candidate = v;
                }
            }
        }

        if (parent_candidate == -1) {
            return 0; // No valid parent found for node u
        }

        num_edges++;

        // Determine if there are multiple ways to reconstruct the tree
        // If adj_sets[u].count == adj_sets[parent_candidate].count - 1,
        // it means u is a direct child of parent_candidate and parent_candidate's set
        // contains only parent_candidate itself and all nodes in u's set.
        // This implies a unique parent relationship.
        // If adj_sets[u].count < adj_sets[parent_candidate].count - 1,
        // it means there are other nodes in adj_sets[parent_candidate] but not in adj_sets[u]
        // (besides parent_candidate itself). This indicates flexibility in tree structure,
        // as u is not a direct child of parent_candidate, leading to 2 ways.
        if (adj_sets[u].count < adj_sets[parent_candidate].count - 1) {
            num_ways = 2;
        }
    }

    // A valid tree must have N-1 edges for N nodes.
    if (num_edges != unique_nodes_count - 1) {
        return 0; 
    }

    return num_ways;
}