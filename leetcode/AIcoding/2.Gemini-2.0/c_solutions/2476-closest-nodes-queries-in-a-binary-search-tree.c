#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void inorder(struct TreeNode* root, int* arr, int* size) {
    if (!root) return;
    inorder(root->left, arr, size);
    arr[(*size)++] = root->val;
    inorder(root->right, arr, size);
}

int* closestNodes(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    int* arr = (int*)malloc(100001 * sizeof(int));
    int size = 0;
    inorder(root, arr, &size);

    int* result = (int*)malloc(2 * queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int min = -1, max = -1;

        // Find min
        int left = 0, right = size - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] <= query) {
                min = arr[mid];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        // Find max
        left = 0, right = size - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] >= query) {
                max = arr[mid];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        result[2 * i] = min;
        result[2 * i + 1] = max;
    }

    return result;
}