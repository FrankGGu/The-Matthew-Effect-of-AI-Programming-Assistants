#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int to;
    long long weight;
    struct Node* next;
} Node;

typedef struct {
    Node* head;
} AdjList;

long long maxSumAfterEdgeRemoval(int n, int** edges, int edgesSize, int* edgeIndices, int edgeIndicesSize) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].head = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        long long w = edges[i][2];
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->to = v;
        newNode->weight = w;
        newNode->next = adj[u].head;
        adj[u].head = newNode;

        newNode = (Node*)malloc(sizeof(Node));
        newNode->to = u;
        newNode->weight = w;
        newNode->next = adj[v].head;
        adj[v].head = newNode;
    }

    long long* total = (long long*)malloc(n * sizeof(long long));
    long long* subtree = (long long*)malloc(n * sizeof(long long));

    void dfs(int node, int parent) {
        subtree[node] = 0;
        for (Node* curr = adj[node].head; curr; curr = curr->next) {
            if (curr->to != parent) {
                dfs(curr->to, node);
                subtree[node] += subtree[curr->to] + curr->weight;
            }
        }
    }

    dfs(0, -1);

    long long sum = 0;
    for (int i = 0; i < n; i++) {
        sum += subtree[i];
    }

    long long result = 0;
    for (int i = 0; i < edgeIndicesSize; i++) {
        int idx = edgeIndices[i];
        int u = edges[idx][0];
        int v = edges[idx][1];
        long long w = edges[idx][2];

        long long left = 0;
        long long right = 0;

        if (subtree[u] > subtree[v]) {
            left = subtree[v];
            right = sum - subtree[v];
        } else {
            left = subtree[u];
            right = sum - subtree[u];
        }

        result = (result > (left + right)) ? result : (left + right);
    }

    free(subtree);
    free(total);
    for (int i = 0; i < n; i++) {
        Node* curr = adj[i].head;
        while (curr) {
            Node* next = curr->next;
            free(curr);
            curr = next;
        }
    }
    free(adj);
    return result;
}