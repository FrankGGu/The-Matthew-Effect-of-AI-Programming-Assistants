#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

bool validateBinaryTreeNodes(int n, int* leftChild, int leftChildSize, int* rightChild, int rightChildSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        if (leftChild[i] != -1) {
            if (parent[leftChild[i]] != -1) {
                free(parent);
                return false;
            }
            parent[leftChild[i]] = i;
        }
        if (rightChild[i] != -1) {
            if (parent[rightChild[i]] != -1) {
                free(parent);
                return false;
            }
            parent[rightChild[i]] = i;
        }
    }

    int root = -1;
    for (int i = 0; i < n; i++) {
        if (parent[i] == -1) {
            if (root == -1) {
                root = i;
            } else {
                free(parent);
                return false;
            }
        }
    }

    if (root == -1) {
        free(parent);
        return false;
    }

    int* visited = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    int queue[n];
    int front = 0, rear = 0;
    queue[rear++] = root;
    visited[root] = 1;

    while (front < rear) {
        int node = queue[front++];
        if (leftChild[node] != -1) {
            if (visited[leftChild[node]]) {
                free(parent);
                free(visited);
                return false;
            }
            visited[leftChild[node]] = 1;
            queue[rear++] = leftChild[node];
        }
        if (rightChild[node] != -1) {
            if (visited[rightChild[node]]) {
                free(parent);
                free(visited);
                return false;
            }
            visited[rightChild[node]] = 1;
            queue[rear++] = rightChild[node];
        }
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (visited[i]) {
            count++;
        }
    }

    free(parent);
    free(visited);
    return count == n;
}