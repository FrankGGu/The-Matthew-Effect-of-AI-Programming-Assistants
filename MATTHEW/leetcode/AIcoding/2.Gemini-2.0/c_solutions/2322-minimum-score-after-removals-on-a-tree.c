#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 1005

int n;
int values[MAXN];
int adj[MAXN][MAXN];
int adj_size[MAXN];
int visited[MAXN];
int subtree_xor[MAXN];
int ans = 1e9;

void dfs(int u) {
    visited[u] = 1;
    subtree_xor[u] = values[u];
    for (int i = 0; i < adj_size[u]; i++) {
        int v = adj[u][i];
        if (!visited[v]) {
            dfs(v);
            subtree_xor[u] ^= subtree_xor[v];
        }
    }
}

void solve(int edge1_u, int edge1_v, int edge2_u, int edge2_v) {
    int a, b, c;

    for (int i = 1; i <= n; i++) {
        visited[i] = 0;
    }

    int root_a = edge1_u, root_b = edge2_u;

    visited[edge1_v] = 1;
    int xor_a = subtree_xor[edge1_v];

    visited[edge2_v] = 1;
    int xor_b = subtree_xor[edge2_v];

    int xor_all = subtree_xor[1];
    c = xor_all ^ xor_a ^ xor_b;

    a = xor_a;
    b = xor_b;

    int max_val = a > b ? a : b;
    max_val = max_val > c ? max_val : c;

    int min_val = a < b ? a : b;
    min_val = min_val < c ? min_val : c;

    int score = max_val - min_val;

    if (score < ans) {
        ans = score;
    }
}

int minimumScore(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize){
    n = numsSize;
    for (int i = 0; i <= n; i++) {
        adj_size[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        values[i + 1] = nums[i];
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] + 1;
        int v = edges[i][1] + 1;
        adj[u][adj_size[u]++] = v;
        adj[v][adj_size[v]++] = u;
    }

    for (int i = 1; i <= n; i++) {
        visited[i] = 0;
    }

    dfs(1);

    ans = 1e9;
    for (int i = 0; i < edgesSize; i++) {
        for (int j = i + 1; j < edgesSize; j++) {
            solve(edges[i][0] + 1, edges[i][1] + 1, edges[j][0] + 1, edges[j][1] + 1);
            solve(edges[i][1] + 1, edges[i][0] + 1, edges[j][0] + 1, edges[j][1] + 1);
            solve(edges[i][0] + 1, edges[i][1] + 1, edges[j][1] + 1, edges[j][0] + 1);
            solve(edges[i][1] + 1, edges[i][0] + 1, edges[j][1] + 1, edges[j][0] + 1);

            int u1 = edges[i][0] + 1;
            int v1 = edges[i][1] + 1;
            int u2 = edges[j][0] + 1;
            int v2 = edges[j][1] + 1;

            visited[1] = 0;
            visited[u1] = 0;
            visited[v1] = 0;
            visited[u2] = 0;
            visited[v2] = 0;
        }
    }

    return ans;
}