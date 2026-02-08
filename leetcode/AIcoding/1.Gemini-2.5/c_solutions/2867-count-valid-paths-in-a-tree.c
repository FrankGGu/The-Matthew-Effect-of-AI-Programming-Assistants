#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_N 100001

bool is_prime[MAX_N];
int adj_head[MAX_N];
int adj_next[2 * (MAX_N - 1)];
int adj_val[2 * (MAX_N - 1)];
int edge_idx;

bool visited[MAX_N];

int stack[MAX_N];
int stack_top;

void sieve(int n) {
    memset(is_prime, true, sizeof(bool) * (n + 1));
    is_prime[0] = false;
    is_prime[1] = false;
    for (int p = 2; p * p <= n; p++) {
        if (is_prime[p]) {
            for (int i = p * p; i <= n; i += p)
                is_prime[i] = false;
        }
    }
}

void init_adj_list(int n) {
    memset(adj_head, -1, sizeof(int) * (n + 1));
    edge_idx = 0;
}

void add_edge(int u, int v) {
    adj_val[edge_idx] = v;
    adj_next[edge_idx] = adj_head[u];
    adj_head[u] = edge_idx;
    edge_idx++;
}

long long iterative_dfs(int start_node) {
    long long count = 0;
    stack_top = 0;

    stack[stack_top++] = start_node;
    visited[start_node] = true;
    count++;

    while (stack_top > 0) {
        int u = stack[--stack_top];

        for (int i = adj_head[u]; i != -1; i = adj_next[i]) {
            int v = adj_val[i];
            if (is_prime[v] && !visited[v]) {
                visited[v] = true;
                count++;
                stack[stack_top++] = v;
            }
        }
    }
    return count;
}

long long countPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    sieve(n);

    init_adj_list(n);
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v);
        add_edge(v, u);
    }

    memset(visited, false, sizeof(bool) * (n + 1));

    long long total_valid_paths = 0;

    for (int i = 1; i <= n; i++) {
        if (is_prime[i] && !visited[i]) {
            long long k = iterative_dfs(i);
            total_valid_paths += k * (k + 1) / 2;
        }
    }

    return total_valid_paths;
}