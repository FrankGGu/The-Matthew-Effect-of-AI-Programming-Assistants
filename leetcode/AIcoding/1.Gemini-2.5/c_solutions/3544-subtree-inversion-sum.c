#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

long long totalInversionSum;

int* mergeAndCount(int* arr1, int size1, int* arr2, int size2, int* returnSize) {
    int* merged = (int*)malloc(sizeof(int) * (size1 + size2));
    int i = 0, j = 0, k = 0;

    while (i < size1 && j < size2) {
        if (arr1[i] <= arr2[j]) {
            merged[k++] = arr1[i++];
        } else {
            // If arr1[i] > arr2[j], then arr1[i] forms an inversion
            // with arr2[j]. Since arr1 is sorted, all remaining elements
            // in arr1 (from index i to size1-1) will also be greater than arr2[j].
            // This is the standard merge sort inversion counting logic.
            totalInversionSum += (long long)(size1 - i);
            merged[k++] = arr2[j++];
        }
    }

    // Add remaining elements from arr1, if any
    while (i < size1) {
        merged[k++] = arr1[i++];
    }
    // Add remaining elements from arr2, if any
    while (j < size2) {
        merged[k++] = arr2[j++];
    }

    *returnSize = size1 + size2;

    // Free the input arrays as their contents have been merged
    if (arr1 != NULL) free(arr1);
    if (arr2 != NULL) free(arr2);

    return merged;
}

int* dfs(struct TreeNode* node, int* returnSize) {
    if (node == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int left_size = 0;
    int* left_vals = dfs(node->left, &left_size);

    int right_size = 0;
    int* right_vals = dfs(node->right, &right_size);

    // Create a temporary array for the current node's value.
    // This allows us to treat node->val as a sorted list of size 1.
    int node_val_arr_size = 1;
    int* node_val_arr = (int*)malloc(sizeof(int));
    node_val_arr[0] = node->val;

    // First merge: Combine values from the left subtree with the current node's value.
    // This counts inversions where one element is from the left subtree and the other is the current node.
    // Example: if left_vals = [8, 9] and node->val = 7, then (8,7) and (9,7) are inversions.
    int temp_merged_size = 0;
    int* temp_merged = mergeAndCount(left_vals, left_size, node_val_arr, node_val_arr_size, &temp_merged_size);

    // Second merge: Combine the result of the first merge (sorted left_vals + node->val) with right_vals.
    // This counts inversions between:
    // 1. elements from the left subtree and the right subtree.
    // 2. the current node and elements from the right subtree.
    // Example: if temp_merged = [5, 7, 10] and right_vals = [6, 11].
    // When merging, (7,6) and (10,6) would be counted as inversions.
    int final_merged_size = 0;
    int* final_merged = mergeAndCount(temp_merged, temp_merged_size, right_vals, right_size, &final_merged_size);

    *returnSize = final_merged_size;
    return final_merged;
}

long long subtreeInversionSum(struct TreeNode* root) {
    totalInversionSum = 0; // Reset global sum for each test case
    int dummy_size = 0;

    // The DFS function returns the sorted list of all values in the entire tree.
    // We don't need this list itself, but the DFS call populates totalInversionSum.
    int* final_subtree_vals = dfs(root, &dummy_size);

    // Free the final array returned by the root DFS call to prevent memory leaks.
    if (final_subtree_vals != NULL) {
        free(final_subtree_vals);
    }

    return totalInversionSum;
}