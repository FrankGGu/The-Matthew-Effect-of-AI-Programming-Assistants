#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode* left;
    struct TreeNode* right;
} TreeNode;

typedef struct {
    int* data;
    int size;
    int capacity;
} Vector;

Vector* vector_create() {
    Vector* v = (Vector*)malloc(sizeof(Vector));
    v->data = NULL;
    v->size = 0;
    v->capacity = 0;
    return v;
}

void vector_push(Vector* v, int value) {
    if (v->size == v->capacity) {
        int new_capacity = (v->capacity == 0) ? 1 : v->capacity * 2;
        int* new_data = (int*)realloc(v->data, new_capacity * sizeof(int));
        if (new_data == NULL) {
            exit(1);
        }
        v->data = new_data;
        v->capacity = new_capacity;
    }
    v->data[v->size++] = value;
}

void vector_free(Vector* v) {
    free(v->data);
    free(v);
}

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

int countPairs(int n, int** edges, int edgesSize, int* queries, int queriesSize) {
    int* degree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int q = 0; q < queriesSize; q++) {
        int k = queries[q];
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (degree[i] >= k) {
                count++;
            }
        }
        result[q] = count;
    }

    free(degree);
    return result;
}