#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int size;
    int count;
} Result;

Result* dfs(TreeNode* root, int k, int* result) {
    if (!root) return (Result*)calloc(1, sizeof(Result));

    Result* left = dfs(root->left, k, result);
    Result* right = dfs(root->right, k, result);

    int totalSize = left->size + right->size + 1;
    Result* res = (Result*)calloc(1, sizeof(Result));
    res->size = totalSize;
    res->count = 1;

    free(left);
    free(right);

    return res;
}

int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int kthLargestPerfectSubtree(TreeNode* root, int k) {
    int* sizes = NULL;
    int sizeCount = 0;

    void traverse(TreeNode* node) {
        if (!node) return;

        Result* res = dfs(node, k, &sizeCount);
        sizes = (int*)realloc(sizes, (sizeCount + 1) * sizeof(int));
        sizes[sizeCount++] = res->size;
        free(res);

        traverse(node->left);
        traverse(node->right);
    }

    traverse(root);

    if (sizeCount < k) return -1;

    qsort(sizes, sizeCount, sizeof(int), compare);
    return sizes[k-1];
}