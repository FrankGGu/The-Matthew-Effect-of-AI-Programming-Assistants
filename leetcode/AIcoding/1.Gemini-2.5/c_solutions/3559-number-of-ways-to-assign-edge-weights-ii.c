#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct AdjNode {
    int dest;
    struct AdjNode* next;
} AdjNode;

typedef struct {
    AdjNode** head;
    int num_nodes;
} Graph;

void add_edge(Graph* graph, int src, int dest) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->dest = dest;
    newNode->next = graph->head[src];
    graph->head[src] = newNode;

    newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->dest = src;
    newNode->next = graph->head[dest];
    graph->head[dest] = newNode;
}

long long** dp; // dp[u][s] = number of ways for subtree at u to have max path sum s from u downwards
int K_val;
int MOD = 1e9 + 7;

long long get_prefix_sum(long long* arr, int index) {
    if (index < 0) return 0;
    return arr[index];
}

void dfs(Graph* graph, int u, int parent) {
    // Initialize dp[u]
    dp[u] = (long long*)calloc(K_val + 1, sizeof(long long));
    dp[u][0] = 1; // Base case: no edges in subtree, max path sum is 0

    AdjNode* current_adj = graph->head[u];
    while (current_adj != NULL) {
        int v = current_adj->dest;
        if (v == parent) {
            current_adj = current_adj->next;
            continue;
        }

        dfs(graph, v, u);

        // Compute dp_v_paths for child v
        // dp_v_paths[L] = sum_{w=1 to K_val} dp[v][L-w] (where L-w >= 0 and L-w <= K_val)
        // This is sum_{x=max(0, L-K_val) to L-1} dp[v][x]
        long long* dp_v_paths = (long long*)calloc(K_val + 1, sizeof(long long));
        long long* prefix_sum_dp_v = (long long*)calloc(K_val + 1, sizeof(long long));

        prefix_sum_dp_v[0] = dp[v][0];
        for (int i = 1; i <= K_val; ++i) {
            prefix_sum_dp_v[i] = (prefix_sum_dp_v[i-1] + dp[v][i]) % MOD;
        }

        for (int L = 1; L <= K_val; ++L) {
            int lower_bound_x = (L - K_val > 0) ? (L - K_val) : 0;
            long long sum_f_v = (get_prefix_sum(prefix_sum_dp_v, L - 1) - get_prefix_sum(prefix_sum_dp_v, lower_bound_x - 1) + MOD) % MOD;
            dp_v_paths[L] = sum_f_v;
        }
        free(prefix_sum_dp_v); // Free temporary prefix sum array

        // Merge dp[u] (current state) with dp_v_paths
        long long* next_dp_u = (long long*)calloc(K_val + 1, sizeof(long long));
        long long* prefix_sum_dp_u = (long long*)calloc(K_val + 1, sizeof(long long));

        prefix_sum_dp_u[0] = dp[u][0];
        for (int i = 1; i <= K_val; ++i) {
            prefix_sum_dp_u[i] = (prefix_sum_dp_u[i-1] + dp[u][i]) % MOD;
        }

        long long* prefix_sum_dp_v_paths = (long long*)calloc(K_val + 1, sizeof(long long));
        prefix_sum_dp_v_paths[0] = dp_v_paths[0];
        for (int i = 1; i <= K_val; ++i) {
            prefix_sum_dp_v_paths[i] = (prefix_sum_dp_v_paths[i-1] + dp_v_paths[i]) % MOD;
        }

        for (int x = 0; x <= K_val; ++x) {
            // Term 1: new_max_len = x (from dp[u][x])
            // We need sum of dp_v_paths[j] where j <= x and x+j <= K_val.
            // So j in [0, min(x, K_val - x)].
            long long term1 = 0;
            if (dp[u][x] != 0) {
                int limit_j = (x < K_val - x) ? x : (K_val - x);
                if (limit_j >= 0) {
                    term1 = (dp[u][x] * get_prefix_sum(prefix_sum_dp_v_paths, limit_j)) % MOD;
                }
            }

            // Term 2: new_max_len = x (from dp_v_paths[x])
            // We need sum of dp[u][i] where i < x and i+x <= K_val.
            // So i in [0, min(x-1, K_val - x)].
            long long term2 = 0;
            if (dp_v_paths[x] != 0) {
                int limit_i = ((x - 1) < (K_val - x)) ? (x - 1) : (K_val - x);
                if (limit_i >= 0) {
                    term2 = (dp_v_paths[x] * get_prefix_sum(prefix_sum_dp_u, limit_i)) % MOD;
                }
            }

            next_dp_u[x] = (term1 + term2) % MOD;
        }

        // Free old dp[u] and assign new one
        free(dp[u]);
        dp[u] = next_dp_u;

        // Free temporary arrays
        free(dp_v_paths);
        free(prefix_sum_dp_u);
        free(prefix_sum_dp_v_paths);

        current_adj = current_adj->next;
    }
}

int numberOfWays(int n, int** edges, int edgesSize, int* edgesColSize, int k) {
    K_val = k;

    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->num_nodes = n;
    graph->head = (AdjNode**)calloc(n, sizeof(AdjNode*));

    for (int i = 0; i < edgesSize; ++i) {
        add_edge(graph, edges[i][0], edges[i][1]);
    }

    dp = (long long**)calloc(n, sizeof(long long*));

    dfs(graph, 0, -1); // Start DFS from node 0, parent -1

    long long total_ways = 0;
    for (int s = 0; s <= K_val; ++s) {
        total_ways = (total_ways + dp[0][s]) % MOD;
    }

    // Free memory
    for (int i = 0; i < n; ++i) {
        if (dp[i]) { // Check if dp[i] was allocated (e.g., if n=1, only dp[0] is allocated)
            free(dp[i]);
        }
        AdjNode* current = graph->head[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph->head);
    free(graph);
    free(dp);

    return (int)total_ways;
}