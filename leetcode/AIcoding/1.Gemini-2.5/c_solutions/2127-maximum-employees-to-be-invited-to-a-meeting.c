#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset
#include <stdio.h>

#define MAXN 100005

int visited_dfs[MAXN]; // 0: unvisited, 1: visiting (on current path), 2: visited (processed)
bool is_cycle_node[MAXN];
int favorite_global[MAXN];
int N_global;

int memo_depth[MAXN]; // Stores max length of path of non-cycle nodes ending at u
typedef struct Node {
    int val;
    struct Node* next;
} Node;
Node* rev_adj[MAXN];

void add_edge_rev(int u, int v) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = v;
    newNode->next = rev_adj[u];
    rev_adj[u] = newNode;
}

void find_cycles_dfs(int u, int* path_nodes, int* path_len, long long* cycles_ge_3_len_sum, int** two_cycles_nodes_ptr, int* two_cycles_count_ptr) {
    visited_dfs[u] = 1; // Mark as visiting
    path_nodes[(*path_len)++] = u;

    int v = favorite_global[u];

    if (visited_dfs[v] == 0) { // Not visited, continue DFS
        find_cycles_dfs(v, path_nodes, path_len, cycles_ge_3_len_sum, two_cycles_nodes_ptr, two_cycles_count_ptr);
    } else if (visited_dfs[v] == 1) { // Cycle detected, v is on current path
        int cycle_start_idx = -1;
        for (int i = 0; i < *path_len; ++i) {
            if (path_nodes[i] == v) {
                cycle_start_idx = i;
                break;
            }
        }

        int cycle_length = *path_len - cycle_start_idx;
        if (cycle_length >= 3) {
            *cycles_ge_3_len_sum += cycle_length;
            for (int i = cycle_start_idx; i < *path_len; ++i) {
                is_cycle_node[path_nodes[i]] = true;
            }
        } else if (cycle_length == 2) { // A <-> B cycle
            if (*two_cycles_count_ptr == 0) { // Initial allocation
                 *two_cycles_nodes_ptr = (int**)malloc(10 * sizeof(int*));
            } else if (*two_cycles_count_ptr % 10 == 0) { // Reallocate if needed
                *two_cycles_nodes_ptr = (int**)realloc(*two_cycles_nodes_ptr, (*two_cycles_count_ptr + 10) * sizeof(int*));
            }
            (*two_cycles_nodes_ptr)[*two_cycles_count_ptr] = (int*)malloc(2 * sizeof(int));
            (*two_cycles_nodes_ptr)[*two_cycles_count_ptr][0] = path_nodes[cycle_start_idx];
            (*two_cycles_nodes_ptr)[*two_cycles_count_ptr][1] = path_nodes[cycle_start_idx + 1];
            (*two_cycles_count_ptr)++;

            is_cycle_node[path_nodes[cycle_start_idx]] = true;
            is_cycle_node[path_nodes[cycle_start_idx + 1]] = true;
        }
    }

    visited_dfs[u] = 2; // Mark current node as fully visited
    (*path_len)--; // Remove u from current path
}

int dfs_get_max_incoming_len(int u) {
    if (memo_depth[u] != -1) {
        return memo_depth[u];
    }

    if (is_cycle_node[u]) {
        return memo_depth[u] = 0; 
    }

    int current_max_len = 0;
    Node* current = rev_adj[u];
    while (current != NULL) {
        int v = current->val;
        if (!is_cycle_node[v]) { 
            int len = dfs_get_max_incoming_len(v) + 1;
            if (len > current_max_len) {
                current_max_len = len;
            }
        }
        current = current->next;
    }

    return memo_depth[u] = current_max_len;
}

long long maximumInvitations(int* favorite, int favoriteSize) {
    N_global = favoriteSize;
    memcpy(favorite_global, favorite, N_global * sizeof(int));

    memset(visited_dfs, 0, sizeof(visited_dfs));
    memset(is_cycle_node, false, sizeof(is_cycle_node));

    for (int i = 0; i < N_global; ++i) {
        rev_adj[i] = NULL; // Initialize reverse adjacency list
    }

    long long cycles_ge_3_len_sum = 0;
    int* path_nodes = (int*)malloc(N_global * sizeof(int));
    int path_len = 0;

    int** two_cycles_nodes = NULL;
    int two_cycles_count = 0;

    for (int i = 0; i < N_global; ++i) {
        if (visited_dfs[i] == 0) {
            path_len = 0; 
            find_cycles_dfs(i, path_nodes, &path_len, &cycles_ge_3_len_sum, &two_cycles_nodes, &two_cycles_count);
        }
    }
    free(path_nodes);

    for (int i = 0; i < N_global; ++i) {
        add_edge_rev(favorite_global[i], i);
    }

    memset(memo_depth, -1, sizeof(memo_depth));

    long long two_cycles_sum_with_tails = 0;
    for (int i = 0; i < two_cycles_count; ++i) {
        int node_A = two_cycles_nodes[i][0];
        int node_B = two_cycles_nodes[i][1];

        int max_tail_A = 0;
        Node* current = rev_adj[node_A];
        while(current != NULL) {
            int v = current->val;
            if (!is_cycle_node[v]) {
                int len = dfs_get_max_incoming_len(v) + 1;
                if (len > max_tail_A) {
                    max_tail_A = len;
                }
            }
            current = current->next;
        }

        int max_tail_B = 0;
        current = rev_adj[node_B];
        while(current != NULL) {
            int v = current->val;
            if (!is_cycle_node[v]) {
                int len = dfs_get_max_incoming_len(v) + 1;
                if (len > max_tail_B) {
                    max_tail_B = len;
                }
            }
            current = current->next;
        }

        two_cycles_sum_with_tails += (2 + max_tail_A + max_tail_B);

        free(two_cycles_nodes[i]);
    }
    if (two_cycles_nodes != NULL) {
        free(two_cycles_nodes);
    }

    for (int i = 0; i < N_global; ++i) {
        Node* current = rev_adj[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }

    return (cycles_ge_3_len_sum > two_cycles_sum_with_tails) ? cycles_ge_3_len_sum : two_cycles_sum_with_tails;
}