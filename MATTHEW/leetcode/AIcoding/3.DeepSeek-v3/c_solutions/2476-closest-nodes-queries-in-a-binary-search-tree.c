/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

void inorder(struct TreeNode* root, int* arr, int* idx) {
    if (!root) return;
    inorder(root->left, arr, idx);
    arr[(*idx)++] = root->val;
    inorder(root->right, arr, idx);
}

int binarySearchMin(int* arr, int size, int target) {
    int left = 0, right = size - 1;
    int res = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] <= target) {
            res = arr[mid];
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return res;
}

int binarySearchMax(int* arr, int size, int target) {
    int left = 0, right = size - 1;
    int res = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] >= target) {
            res = arr[mid];
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return res;
}

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** closestNodes(struct TreeNode* root, int* queries, int queriesSize, int* returnSize, int** returnColumnSizes) {
    int arr[100000];
    int idx = 0;
    inorder(root, arr, &idx);

    *returnSize = queriesSize;
    int** res = (int**)malloc(queriesSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(queriesSize * sizeof(int));

    for (int i = 0; i < queriesSize; i++) {
        res[i] = (int*)malloc(2 * sizeof(int));
        (*returnColumnSizes)[i] = 2;

        int minVal = binarySearchMin(arr, idx, queries[i]);
        int maxVal = binarySearchMax(arr, idx, queries[i]);

        res[i][0] = minVal;
        res[i][1] = maxVal;
    }

    return res;
}