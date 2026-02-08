#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int size;
    int *nodes;
} Tree;

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void addEdge(int** adj, int u, int v) {
    adj[u][v] = 1;
    adj[v][u] = 1;
}

int countNodes(TreeNode* root) {
    if (!root) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

void buildAdjList(TreeNode* root, int** adj, int* index) {
    if (!root) return;
    int u = *index;
    (*index)++;
    if (root->left) {
        addEdge(adj, u, *index);
        buildAdjList(root->left, adj, index);
    }
    if (root->right) {
        addEdge(adj, u, *index);
        buildAdjList(root->right, adj, index);
    }
}

int maxTargetNodes(TreeNode* root1, TreeNode* root2) {
    int size1 = countNodes(root1);
    int size2 = countNodes(root2);
    int totalSize = size1 + size2;
    int** adj = (int**)malloc(totalSize * sizeof(int*));
    for (int i = 0; i < totalSize; i++) {
        adj[i] = (int*)calloc(totalSize, sizeof(int));
    }

    int index = 0;
    buildAdjList(root1, adj, &index);
    buildAdjList(root2, adj, &index);

    int* visited = (int*)calloc(totalSize, sizeof(int));
    int* componentSize = (int*)calloc(totalSize, sizeof(int));
    int componentCount = 0;

    for (int i = 0; i < totalSize; i++) {
        if (!visited[i]) {
            int size = 0;
            int* queue = (int*)malloc(totalSize * sizeof(int));
            int front = 0, rear = 0;
            queue[rear++] = i;
            visited[i] = 1;
            while (front < rear) {
                int u = queue[front++];
                size++;
                for (int v = 0; v < totalSize; v++) {
                    if (adj[u][v] && !visited[v]) {
                        visited[v] = 1;
                        queue[rear++] = v;
                    }
                }
            }
            for (int j = 0; j < totalSize; j++) {
                if (visited[j]) {
                    componentSize[j] = size;
                }
            }
            componentCount++;
        }
    }

    int max = 0;
    for (int i = 0; i < totalSize; i++) {
        if (componentSize[i] > max) {
            max = componentSize[i];
        }
    }

    for (int i = 0; i < totalSize; i++) {
        free(adj[i]);
    }
    free(adj);
    free(visited);
    free(componentSize);
    return max;
}