#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode** generateTreesRecursive(int start, int end, int* returnSize) {
    if (start > end) {
        *returnSize = 1;
        struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
        result[0] = NULL;
        return result;
    }

    if (start == end) {
        *returnSize = 1;
        struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
        struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        node->val = start;
        node->left = NULL;
        node->right = NULL;
        result[0] = node;
        return result;
    }

    int totalTrees = 0;
    struct TreeNode** allTrees = NULL;

    for (int i = start; i <= end; i++) {
        int leftSize = 0;
        struct TreeNode** leftSubtrees = generateTreesRecursive(start, i - 1, &leftSize);

        int rightSize = 0;
        struct TreeNode** rightSubtrees = generateTreesRecursive(i + 1, end, &rightSize);

        for (int j = 0; j < leftSize; j++) {
            for (int k = 0; k < rightSize; k++) {
                struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                root->val = i;
                root->left = leftSubtrees[j];
                root->right = rightSubtrees[k];

                totalTrees++;
                allTrees = (struct TreeNode**)realloc(allTrees, totalTrees * sizeof(struct TreeNode*));
                allTrees[totalTrees - 1] = root;
            }
        }
        free(leftSubtrees);
        free(rightSubtrees);
    }

    *returnSize = totalTrees;
    return allTrees;
}

struct TreeNode** generateTrees(int n, int* returnSize) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }
    return generateTreesRecursive(1, n, returnSize);
}