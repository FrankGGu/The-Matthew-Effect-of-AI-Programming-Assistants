#include <stdlib.h> // For malloc, realloc, free

void inorder_traverse(struct TreeNode* root, int** values_arr, int* values_count, int* values_capacity) {
    if (!root) return;

    inorder_traverse(root->left, values_arr, values_count, values_capacity);

    if (*values_count == *values_capacity) {
        *values_capacity *= 2;
        if (*values_capacity == 0) *values_capacity = 1; // Handle initial capacity 0 case
        *values_arr = (int*)realloc(*values_arr, sizeof(int) * (*values_capacity));
    }
    (*values_arr)[(*values_count)++] = root->val;

    inorder_traverse(root->right, values_arr, values_count, values_capacity);
}

int find_max_le(int* arr, int size, int target) {
    int low = 0, high = size - 1;
    int ans = -1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] <= target) {
            ans = arr[mid];
            low = mid + 1; // Try to find a larger one on the right
        } else {
            high = mid - 1; // Current is too large, look left
        }
    }
    return ans;
}

int find_min_ge(int* arr, int size, int target) {
    int low = 0, high = size - 1;
    int ans = -1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= target) {
            ans = arr[mid];
            high = mid - 1; // Current is a candidate, try to find a smaller one on the left
        } else {
            low = mid + 1; // Current is too small, look right
        }
    }
    return ans;
}

int** closestNodes(struct TreeNode* root, int* queries, int queriesSize, int* returnSize, int** returnColumnSizes) {
    // Step 1: Perform in-order traversal to get all BST values in a sorted array.
    int* bst_values = NULL;
    int bst_values_count = 0;
    int bst_values_capacity = 100; // Initial capacity, will reallocate as needed
    bst_values = (int*)malloc(sizeof(int) * bst_values_capacity);
    if (bst_values == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    inorder_traverse(root, &bst_values, &bst_values_count, &bst_values_capacity);

    // Reallocate to exact size to save memory if capacity was much larger than count.
    if (bst_values_count == 0) {
        free(bst_values); // Free if the tree was empty
        bst_values = NULL;
    } else {
        bst_values = (int*)realloc(bst_values, sizeof(int) * bst_values_count);
    }

    // Step 2: Process each query using binary search on the sorted BST values.
    *returnSize = queriesSize;
    int** result = (int**)malloc(sizeof(int*) * queriesSize);
    if (result == NULL) {
        free(bst_values);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    *returnColumnSizes = (int*)malloc(sizeof(int) * queriesSize);
    if (*returnColumnSizes == NULL) {
        free(bst_values);
        free(result);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < queriesSize; ++i) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        if (result[i] == NULL) {
            // Handle malloc failure: free previously allocated memory
            for (int j = 0; j < i; ++j) {
                free(result[j]);
            }
            free(result);
            free(bst_values);
            free(*returnColumnSizes);
            *returnSize = 0;
            return NULL;
        }
        (*returnColumnSizes)[i] = 2;

        if (bst_values_count == 0) { // If BST was empty, no nodes to find
            result[i][0] = -1;
            result[i][1] = -1;
        } else {
            result[i][0] = find_max_le(bst_values, bst_values_count, queries[i]);
            result[i][1] = find_min_ge(bst_values, bst_values_count, queries[i]);
        }
    }

    free(bst_values); // Free the temporary sorted array of BST values

    return result;
}