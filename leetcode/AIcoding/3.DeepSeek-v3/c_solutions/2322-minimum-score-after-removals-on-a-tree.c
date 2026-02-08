/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

#include <stdlib.h>
#include <string.h>

#define MAX_N 1000

int head[MAX_N], nxt[2 * MAX_N], to[2 * MAX_N], cnt;
int nums[MAX_N], n;
int xor_total;
int xor_sub[MAX_N];
int visited[MAX_N];
int res;

void addEdge(int u, int v) {
    nxt[cnt] = head[u];
    to[cnt] = v;
    head[u] = cnt++;
}

int dfs1(int u, int parent) {
    xor_sub[u] = nums[u];
    for (int i = head[u]; i != -1; i = nxt[i]) {
        int v = to[i];
        if (v == parent) continue;
        xor_sub[u] ^= dfs1(v, u);
    }
    return xor_sub[u];
}

void dfs2(int u, int parent, int x) {
    for (int i = head[u]; i != -1; i = nxt[i]) {
        int v = to[i];
        if (v == parent) continue;
        int rem = xor_total ^ x;
        int a = xor_sub[v];
        int b = rem ^ a;
        int score = (a > b ? (a > x ? a : x) : (b > x ? b : x)) - 
                   (a < b ? (a < x ? a : x) : (b < x ? b : x));
        if (score < res) res = score;
        dfs2(v, u, x);
    }
}

void dfs3(int u, int parent) {
    for (int i = head[u]; i != -1; i = nxt[i]) {
        int v = to[i];
        if (v == parent) continue;
        dfs3(v, u);
        int a = xor_sub[v];
        int b = xor_total ^ a;
        int x = a;
        dfs2(v, u, x);
        x = b;
        dfs2(u, v, x);
    }
}

int minimumScore(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize) {
    n = numsSize;
    cnt = 0;
    memset(head, -1, sizeof(head));
    for (int i = 0; i < n; i++) {
        this->nums[i] = nums[i];
    }
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        addEdge(u, v);
        addEdge(v, u);
    }

    xor_total = 0;
    for (int i = 0; i < n; i++) {
        xor_total ^= nums[i];
    }

    dfs1(0, -1);

    res = 1 << 30;
    dfs3(0, -1);

    return res;
}