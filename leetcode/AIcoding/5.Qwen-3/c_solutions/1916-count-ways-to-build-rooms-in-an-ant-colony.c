#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* to;
    int* next;
    int size;
} Edge;

long long mod = 1000000007;

long long pow_mod(long long a, long long b) {
    long long res = 1;
    while (b > 0) {
        if (b % 2 == 1) res = (res * a) % mod;
        a = (a * a) % mod;
        b /= 2;
    }
    return res;
}

long long comb(int n, int k, long long* fact, long long* inv_fact) {
    if (k < 0 || k > n) return 0;
    return fact[n] * inv_fact[k] % mod * inv_fact[n - k] % mod;
}

long long dfs(int u, int parent, Edge* edges, int* children, int* depth, long long* fact, long long* inv_fact, int* size) {
    long long res = 1;
    for (int i = 0; i < children[u]; i++) {
        int v = edges->to[i];
        if (v == parent) continue;
        long long sub = dfs(v, u, edges, children, depth, fact, inv_fact, size);
        res = res * sub % mod;
        res = res * comb(size[v], 1, fact, inv_fact) % mod;
    }
    return res;
}

long long countWays(int n, int** edges, int edgesSize, int* edgesColSize) {
    Edge* adj = (Edge*)malloc((n + 1) * sizeof(Edge));
    for (int i = 0; i <= n; i++) {
        adj[i].size = 0;
        adj[i].to = NULL;
        adj[i].next = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u].size++;
        adj[v].size++;
    }

    for (int i = 0; i <= n; i++) {
        adj[i].to = (int*)malloc(adj[i].size * sizeof(int));
        adj[i].next = (int*)malloc(adj[i].size * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u].to[adj[u].size - 1] = v;
        adj[v].to[adj[v].size - 1] = u;
    }

    int* size = (int*)malloc((n + 1) * sizeof(int));
    long long* fact = (long long*)malloc((n + 1) * sizeof(long long));
    long long* inv_fact = (long long*)malloc((n + 1) * sizeof(long long));

    fact[0] = 1;
    for (int i = 1; i <= n; i++) {
        fact[i] = fact[i - 1] * i % mod;
    }

    inv_fact[n] = pow_mod(fact[n], mod - 2);
    for (int i = n - 1; i >= 0; i--) {
        inv_fact[i] = inv_fact[i + 1] * (i + 1) % mod;
    }

    for (int i = 0; i <= n; i++) {
        size[i] = 1;
    }

    dfs(1, -1, adj, (int*)adj, (int*)adj, fact, inv_fact, size);

    long long result = 1;
    for (int i = 1; i <= n; i++) {
        result = result * comb(size[i], 1, fact, inv_fact) % mod;
    }

    for (int i = 0; i <= n; i++) {
        free(adj[i].to);
        free(adj[i].next);
    }
    free(adj);
    free(size);
    free(fact);
    free(inv_fact);

    return result;
}