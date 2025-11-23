#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int *data;
    int size;
} Vector;

Vector* vector_create(int capacity) {
    Vector *v = (Vector*)malloc(sizeof(Vector));
    v->data = (int*)malloc(capacity * sizeof(int));
    v->size = 0;
    return v;
}

void vector_push(Vector *v, int val) {
    v->data[v->size++] = val;
}

void vector_free(Vector *v) {
    free(v->data);
    free(v);
}

TreeNode* createTreeNode(int val) {
    TreeNode *node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

int* findAncestor(int n, int parent[], int u, int v) {
    int *path = (int*)malloc((n + 1) * sizeof(int));
    int index = 0;
    while (u != -1) {
        path[index++] = u;
        u = parent[u];
    }
    for (int i = 0; i < index; i++) {
        if (path[i] == v) {
            int *result = (int*)malloc(2 * sizeof(int));
            result[0] = path[i];
            result[1] = i;
            return result;
        }
    }
    return NULL;
}

int dfs(int n, int parent[], TreeNode *root, int *count, int target) {
    if (!root) return 0;
    int left = dfs(n, parent, root->left, count, target);
    int right = dfs(n, parent, root->right, count, target);
    int total = left + right + 1;
    if (total == target) (*count)++;
    return total;
}

int minScore(int n, int** edges, int edgesSize, int* edgesColSize, int[] nums, int numsSize) {
    int *adj = (int*)calloc(n * n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        adj[u * n + v] = 1;
        adj[v * n + u] = 1;
    }

    int *parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) parent[i] = -1;

    int *visited = (int*)calloc(n, sizeof(int));
    int queue[n], front = 0, rear = 0;
    queue[rear++] = 0;
    visited[0] = 1;

    while (front < rear) {
        int u = queue[front++];
        for (int v = 0; v < n; v++) {
            if (adj[u * n + v] && !visited[v]) {
                visited[v] = 1;
                parent[v] = u;
                queue[rear++] = v;
            }
        }
    }

    int total = 0;
    for (int i = 0; i < n; i++) total += nums[i];

    int maxCount = 0;
    for (int i = 0; i < n; i++) {
        int *path = findAncestor(n, parent, i, 0);
        if (path) {
            int lca = path[0];
            int depth = path[1];
            int count = 0;
            dfs(n, parent, createTreeNode(nums[0]), &count, nums[lca]);
            int score = total - 2 * count;
            if (score < 0) score = 0;
            maxCount = (score > maxCount) ? score : maxCount;
        }
    }

    free(adj);
    free(parent);
    free(visited);
    return maxCount;
}