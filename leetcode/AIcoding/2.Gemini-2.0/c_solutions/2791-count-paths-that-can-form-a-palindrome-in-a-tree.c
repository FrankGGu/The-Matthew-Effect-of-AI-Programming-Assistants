#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct Edge {
    int to;
    int weight;
    struct Edge *next;
};

int countPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    struct Edge** adj = (struct Edge**)malloc(n * sizeof(struct Edge*));
    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        struct Edge* edge1 = (struct Edge*)malloc(sizeof(struct Edge));
        edge1->to = v;
        edge1->weight = w;
        edge1->next = adj[u];
        adj[u] = edge1;

        struct Edge* edge2 = (struct Edge*)malloc(sizeof(struct Edge));
        edge2->to = u;
        edge2->weight = w;
        edge2->next = adj[v];
        adj[v] = edge2;
    }

    int* pathXor = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        pathXor[i] = 0;
    }

    long long count = 0;
    int* freq = (int*)calloc(1 << 20, sizeof(int));
    freq[0] = 1;

    void dfs(int u, int parent, int currentXor) {
        pathXor[u] = currentXor;
        count += freq[currentXor];
        for (int i = 0; i < 20; i++) {
            count += freq[currentXor ^ (1 << i)];
        }
        freq[currentXor]++;

        struct Edge* edge = adj[u];
        while (edge != NULL) {
            int v = edge->to;
            int w = edge->weight;
            if (v != parent) {
                dfs(v, u, currentXor ^ (1 << w));
            }
            edge = edge->next;
        }
        freq[currentXor]--;
    }

    dfs(0, -1, 0);

    for (int i = 0; i < n; i++) {
        struct Edge* edge = adj[i];
        while (edge != NULL) {
            struct Edge* next = edge->next;
            free(edge);
            edge = next;
        }
    }
    free(adj);
    free(pathXor);
    free(freq);

    return (int)count;
}