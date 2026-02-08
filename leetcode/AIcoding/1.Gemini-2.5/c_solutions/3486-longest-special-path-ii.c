#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct AdjNode {
    int to;
    struct AdjNode* next;
} AdjNode;

AdjNode* adj[50005];
int values_global[50005];
int N_global;
int K_global;

int subtree_size[50005];
int depth[50005];
int xor_from_root[50005]; // XOR sum of values from root (node 0) to current node (inclusive)

#define MAX_BITS 30 // For values up to 10^9, 2^30 > 10^9
#define MAX_TRIE_NODES (50005 * MAX_BITS + 5) // N * BITS + a small buffer

int trie_children_dsu[MAX_TRIE_NODES][2];
int trie_max_depth_dsu[MAX_TRIE_NODES]; // Stores max depth for the XOR value ending at this node
int trie_node_idx_dsu;

typedef struct TrieChange {
    int node_idx;
    int old_depth; // -1 indicates a new node was created at node_idx
} TrieChange;

TrieChange trie_changes[MAX_TRIE_NODES]; // Max number of trie nodes
int trie_changes_count;

typedef struct NodeInfo {
    int xor_val;
    int depth_val;
} NodeInfo;

NodeInfo temp_nodes[50005]; // Max N nodes in a subtree
int temp_nodes_count;

int max_ans;

void add_edge(int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->to = v;
    newNode->next = adj[u];
    adj[u] = newNode;
}

void dfs_size(int u, int p) {
    subtree_size[u] = 1;
    AdjNode* curr = adj[u];
    while (curr != NULL) {
        int v = curr->to;
        if (v == p) {
            curr = curr->next;
            continue;
        }
        depth[v] = depth[u] + 1;
        xor_from_root[v] = xor_from_root[u] ^ values_global[v];
        dfs_size(v, u);
        subtree_size[u] += subtree_size[v];
        curr = curr->next;
    }
}

void trie_add_dsu(int val, int d, int record_changes) {
    int curr = 0; // Start from root (index 0)
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (val >> i) & 1;
        if (trie_children_dsu[curr][bit] == 0) {
            trie_children_dsu[curr][bit] = trie_node_idx_dsu++;
            // Initialize new node
            trie_children_dsu[trie_children_dsu[curr][bit]][0] = 0;
            trie_children_dsu[trie_children_dsu[curr][bit]][1] = 0;
            trie_max_depth_dsu[trie_children_dsu[curr][bit]] = -1;
            if (record_changes) {
                // Record that this node was newly created
                trie_changes[trie_changes_count++] = (TrieChange){trie_children_dsu[curr][bit], -1};
            }
        }
        curr = trie_children_dsu[curr][bit];
    }
    // Update max_depth at the final node for the exact value
    if (d > trie_max_depth_dsu[curr]) {
        if (record_changes) {
            // Record old depth before updating
            trie_changes[trie_changes_count++] = (TrieChange){curr, trie_max_depth_dsu[curr]};
        }
        trie_max_depth_dsu[curr] = d;
    }
}

int trie_query_dsu(int target_val) {
    int curr = 0; // Start from root (index 0)
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (target_val >> i) & 1;
        if (trie_children_dsu[curr][bit] == 0) {
            return -1; // Target value not found
        }
        curr = trie_children_dsu[curr][bit];
    }
    return trie_max_depth_dsu[curr];
}

void collect_nodes_query_and_temp_add(int u, int p, int current_LCA_val) {
    // Query for paths where u is one endpoint, and the other endpoint is in the existing Trie
    // Path (u, y) where LCA(u,y) = current_LCA_val
    // xor_path(u,y) = xor_from_root[u] ^ xor_from_root[y] ^ values_global[current_LCA_val] = K_global
    // => xor_from_root[y] = K_global ^ values_global[current_LCA_val] ^ xor_from_root[u]

    int target_xor_y = K_global ^ values_global[current_LCA_val] ^ xor_from_root[u];
    int d_y = trie_query_dsu(target_xor_y);
    if (d_y != -1) {
        int current_path_len = depth[u] + d_y - 2 * depth[current_LCA_val];
        if (current_path_len > max_ans) {
            max_ans = current_path_len;
        }
    }

    temp_nodes[temp_nodes_count++] = (NodeInfo){xor_from_root[u], depth[u]};

    AdjNode* curr = adj[u];
    while (curr != NULL) {
        int v = curr->to;
        if (v == p) {
            curr = curr->next;
            continue;
        }
        collect_nodes_query_and_temp_add(v, u, current_LCA_val);
        curr = curr->next;
    }
}

void dfs_dsu_main_corrected(int u, int p, int keep) {
    int heavy_child = -1;
    int max_s = 0;

    AdjNode* curr = adj[u];
    while (curr != NULL) {
        int v = curr->to;
        if (v == p) {
            curr = curr->next;
            continue;
        }
        if (subtree_size[v] > max_s) {
            max_s = subtree_size[v];
            heavy_child = v;
        }
        curr = curr->next;
    }

    // Process light children
    curr = adj[u];
    while (curr != NULL) {
        int v = curr->to;
        if (v == p || v == heavy_child) {
            curr = curr->next;
            continue;
        }
        dfs_dsu_main_corrected(v, u, 0); // Recursively call for light children, clearing their Tries
        curr = curr->next;
    }

    // Process heavy child, keeping its Trie
    if (heavy_child != -1) {
        dfs_dsu_main_corrected(heavy_child, u, 1);
    }

    // Now, the Trie contains info from heavy_child's subtree (if any).
    // The `trie_changes_count` stores changes from heavy_child's subtree and its ancestors.
    // We need to record changes made by `u` and its light children.
    int current_trie_changes_start_idx = trie_changes_count;

    // Check for single node path u->u
    if (values_global[u] == K_global) {
        if (0 > max_ans) {
            max_ans = 0;
        }
    }

    // First, query for paths where 'u' is one endpoint, and the other endpoint 'x' is in the current Trie.
    // Path (u, x) where LCA(u,x) = u (x is in u's subtree)
    // xor_path(u,x) = xor_from_root[u] ^ xor_from_root[x] ^ values_global[u] = K_global
    // => xor_from_root[x] = K_global ^ values_global[u] ^ xor_from_root[u]
    int target_xor_x_for_u = K_global ^ values_global[u] ^ xor_from_root[u];
    int d_x = trie_query_dsu(target_xor_x_for_u);
    if (d_x != -1) {
        int current_path_len = d_x + depth[u] - 2 * depth[u]; // d_x - depth[u]
        if (current_path_len > max_ans) {
            max_ans = current_path_len;
        }
    }

    // Add 'u' to the Trie.
    trie_add_dsu(xor_from_root[u], depth[u], 1); // Record changes for 'u'

    // Process light children's subtrees
    curr = adj[u];
    while (curr != NULL) {
        int v = curr->to;
        if (v == p || v == heavy_child) {
            curr = curr->next;
            continue;
        }
        temp_nodes_count = 0; // Clear temporary list for this light child
        collect_nodes_query_and_temp_add(v, u, u); // u is the LCA for paths between v's subtree and heavy_child's subtree

        // Add nodes from temp_nodes (from v's subtree) to the main Trie
        for (int i = 0; i < temp_nodes_count; i++) {
            trie_add_dsu(temp_nodes[i].xor_val, temp_nodes[i].depth_val, 1); // Record changes
        }
        curr = curr->next;
    }

    if (!keep) {
        // Revert changes made in this subtree (from current_trie_changes_start_idx to trie_changes_count)
        for (int i = current_trie_changes_start_idx; i < trie_changes_count; i++) {
            TrieChange change = trie_changes[i];
            if (change.old_depth == -1) { // This node was newly created
                trie_children_dsu[change.node_idx][0] = 0;
                trie_children_dsu[change.node_idx][1] = 0;
                trie_max_depth_dsu[change.node_idx] = -1;
            } else { // This node's depth was updated
                trie_max_depth_dsu[change.node_idx] = change.old_depth;
            }
        }
        trie_changes_count = current_trie_changes_start_idx; // Rollback changes count
    }
}

int longestSpecialPath(int n, int** edges, int edgesSize, int* edgesColSize, int* values, int k) {
    N_global = n;
    K_global = k;

    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
        values_global[i] = values[i];
    }

    for (int i = 0; i < edgesSize; i++) {
        add_edge(edges[i][0], edges[i][1]);
        add_edge(edges[i][1], edges[i][0]);
    }

    // Initialize tree properties
    depth[0] = 0;
    xor_from_root[0] = values_global[0]; // XOR sum from root 0 to 0 is just value[0]
    dfs_size(0, -1); // Calculate subtree sizes, depths, and xor_from_root

    // Initialize Trie
    memset(trie_children_dsu, 0, sizeof(trie_children_dsu));
    memset(trie_max_depth_dsu, -1, sizeof(trie_max_depth_dsu));
    trie_node_idx_dsu = 1; // Start trie node indices from 1 (index 0 is a dummy root)

    max_ans = -1;
    trie_changes_count = 0; // Initialize changes tracker

    dfs_dsu_main_corrected(0, -1, 1); // Start DSU on tree from root, keep its Trie

    // Free adjacency list memory
    for (int i = 0; i < n; i++) {
        AdjNode* curr = adj[i];
        while (curr != NULL) {
            AdjNode* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }

    return max_ans;
}