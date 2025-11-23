#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int size;
    int count;
} SubtreeInfo;

typedef struct {
    int *sizes;
    int count;
} SizeList;

SubtreeInfo dfs(struct TreeNode* root, SizeList* sizeList) {
    if (!root) return (SubtreeInfo){0, 0};

    SubtreeInfo left = dfs(root->left, sizeList);
    SubtreeInfo right = dfs(root->right, sizeList);

    int currentSize = 1 + left.size + right.size;
    sizeList->sizes[sizeList->count++] = currentSize;

    return (SubtreeInfo){currentSize, left.count + right.count + 1};
}

int kthLargestPerfectSubtreeSize(struct TreeNode* root, int k) {
    SizeList sizeList;
    sizeList.sizes = (int*)malloc(1000 * sizeof(int));
    sizeList.count = 0;

    dfs(root, &sizeList);

    qsort(sizeList.sizes, sizeList.count, sizeof(int), (int(*)(const void*, const void*))strcmp);

    int result = sizeList.sizes[sizeList.count - k];
    free(sizeList.sizes);

    return result;
}