#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int val;
    struct Node* next;
} Node;

typedef struct {
    int* count;
    int max_color;
} Result;

int max(int a, int b) {
    return a > b ? a : b;
}

void addEdge(Node** adj, int u, int v) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = v;
    newNode->next = adj[u];
    adj[u] = newNode;
}

int dfs(int node, int* visited, int* inStack, Node** adj, int n, int* color, int** colorCount, int* result) {
    if (visited[node]) {
        return 0;
    }
    visited[node] = 1;
    inStack[node] = 1;

    for (Node* curr = adj[node]; curr; curr = curr->next) {
        if (!visited[curr->val]) {
            dfs(curr->val, visited, inStack, adj, n, color, colorCount, result);
        } else if (inStack[curr->val]) {
            return -1;
        }
    }

    inStack[node] = 0;

    for (Node* curr = adj[node]; curr; curr = curr->next) {
        for (int c = 0; c < 26; c++) {
            colorCount[node][c] = max(colorCount[node][c], colorCount[curr->val][c]);
        }
    }

    colorCount[node][color[node]]++;
    result[0] = max(result[0], colorCount[node][color[node]]);
    return 0;
}

int largestColorValue(int n, int** edges, int edgesSize, int* edgesColSize, int* color, int colorSize) {
    Node** adj = (Node**)calloc(n, sizeof(Node*));
    for (int i = 0; i < edgesSize; i++) {
        addEdge(adj, edges[i][0], edges[i][1]);
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int* inStack = (int*)calloc(n, sizeof(int));
    int** colorCount = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        colorCount[i] = (int*)calloc(26, sizeof(int));
    }

    int result[1] = {0};

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            if (dfs(i, visited, inStack, adj, n, color, colorCount, result) == -1) {
                return -1;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(colorCount[i]);
    }
    free(colorCount);
    free(visited);
    free(inStack);
    for (int i = 0; i < n; i++) {
        Node* curr = adj[i];
        while (curr) {
            Node* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }
    free(adj);

    return result[0];
}