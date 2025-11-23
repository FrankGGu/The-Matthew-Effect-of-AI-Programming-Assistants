/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* newNode(int val) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

struct TreeNode** generateTreesHelper(int start, int end, int* returnSize) {
    if (start > end) {
        *returnSize = 1;
        struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
        result[0] = NULL;
        return result;
    }

    struct TreeNode** result = NULL;
    int size = 0;

    for (int i = start; i <= end; i++) {
        int leftSize, rightSize;
        struct TreeNode** leftTrees = generateTreesHelper(start, i - 1, &leftSize);
        struct TreeNode** rightTrees = generateTreesHelper(i + 1, end, &rightSize);

        for (int j = 0; j < leftSize; j++) {
            for (int k = 0; k < rightSize; k++) {
                struct TreeNode* root = newNode(i);
                root->left = leftTrees[j];
                root->right = rightTrees[k];

                size++;
                result = (struct TreeNode**)realloc(result, size * sizeof(struct TreeNode*));
                result[size - 1] = root;
            }
        }

        free(leftTrees);
        free(rightTrees);
    }

    *returnSize = size;
    return result;
}

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
struct TreeNode** generateTrees(int n, int* returnSize) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }
    return generateTreesHelper(1, n, returnSize);
}