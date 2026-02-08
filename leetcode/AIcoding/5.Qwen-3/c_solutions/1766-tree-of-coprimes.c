#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int value;
    int depth;
    int ancestor;
} Pair;

typedef struct {
    int* data;
    int size;
} IntArray;

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

void dfs(TreeNode* node, int depth, int ancestor, int* coprimes, int* result, int* depthArr, int* ancestorArr, int* visited, int* index, int* parent, int* depthList, int* ancestorList) {
    if (!node) return;

    int currentVal = node->val;
    int currentIndex = *index;
    (*index)++;
    depthList[currentIndex] = depth;
    ancestorList[currentIndex] = ancestor;

    for (int i = 0; i < *index; i++) {
        if (gcd(currentVal, depthList[i]) == 1) {
            result[currentIndex] = ancestorList[i];
            break;
        }
    }

    visited[currentVal] = 1;

    if (node->left) {
        dfs(node->left, depth + 1, currentVal, coprimes, result, depthArr, ancestorArr, visited, index, parent, depthList, ancestorList);
    }
    if (node->right) {
        dfs(node->right, depth + 1, currentVal, coprimes, result, depthArr, ancestorArr, visited, index, parent, depthList, ancestorList);
    }

    visited[currentVal] = 0;
}

int* getCoprimesOf(TreeNode* root, int* returnSize) {
    int maxVal = 0;
    int* visited = (int*)calloc(1001, sizeof(int));
    int* depthList = (int*)malloc(10000 * sizeof(int));
    int* ancestorList = (int*)malloc(10000 * sizeof(int));
    int index = 0;

    dfs(root, 0, -1, NULL, NULL, NULL, NULL, visited, &index, NULL, depthList, ancestorList);

    int* result = (int*)malloc(index * sizeof(int));
    for (int i = 0; i < index; i++) {
        result[i] = -1;
    }

    dfs(root, 0, -1, NULL, result, NULL, NULL, visited, &index, NULL, depthList, ancestorList);

    *returnSize = index;
    free(visited);
    free(depthList);
    free(ancestorList);
    return result;
}

int* treeCoprimes(TreeNode* root, int* returnSize) {
    return getCoprimesOf(root, returnSize);
}