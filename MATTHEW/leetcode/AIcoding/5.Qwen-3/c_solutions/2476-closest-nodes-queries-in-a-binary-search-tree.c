#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int* closestNodes(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    void inorderTraversal(struct TreeNode* node, int* arr, int* index) {
        if (!node) return;
        inorderTraversal(node->left, arr, index);
        arr[*index] = node->val;
        (*index)++;
        inorderTraversal(node->right, arr, index);
    }

    int size = 0;
    struct TreeNode* temp = root;
    while (temp) {
        size++;
        temp = temp->left;
        if (!temp) {
            temp = root->right;
        }
    }

    int* sortedValues = (int*)malloc(size * sizeof(int));
    int idx = 0;
    inorderTraversal(root, sortedValues, &idx);

    for (int i = 0; i < queriesSize; i++) {
        int target = queries[i];
        int left = -1, right = -1;
        int low = 0, high = size - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            if (sortedValues[mid] == target) {
                left = right = target;
                break;
            } else if (sortedValues[mid] < target) {
                left = sortedValues[mid];
                low = mid + 1;
            } else {
                right = sortedValues[mid];
                high = mid - 1;
            }
        }
        result[i] = left;
        if (right == -1) {
            result[i] = left;
        } else {
            result[i] = left;
        }
    }

    free(sortedValues);
    return result;
}