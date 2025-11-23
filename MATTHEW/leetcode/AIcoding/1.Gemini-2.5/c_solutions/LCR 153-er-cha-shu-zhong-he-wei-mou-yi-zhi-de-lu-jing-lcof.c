#include <stdlib.h> // Required for malloc, realloc, free

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int** g_result;          // Stores the collection of paths (array of int arrays)
int* g_returnColumnSizes; // Stores the size of each path in g_result
int g_returnSize;        // Current number of paths found
int g_resultCapacity;    // Current allocated capacity for g_result and g_returnColumnSizes

void addPath(int* currentPath, int currentPathSize) {
    // If the current number of paths exceeds capacity, double the capacity.
    if (g_returnSize == g_resultCapacity) {
        g_resultCapacity *= 2;
        g_result = (int**)realloc(g_result, sizeof(int*) * g_resultCapacity);
        g_returnColumnSizes = (int*)realloc(g_returnColumnSizes, sizeof(int) * g_resultCapacity);
    }

    // Allocate memory for the new path and copy elements from currentPath.
    g_result[g_returnSize] = (int*)malloc(sizeof(int) * currentPathSize);
    for (int i = 0; i < currentPathSize; i++) {
        g_result[g_returnSize][i] = currentPath[i];
    }
    // Store the size of this new path.
    g_returnColumnSizes[g_returnSize] = currentPathSize;
    // Increment the count of found paths.
    g_returnSize++;
}

void dfs(struct TreeNode* node, int targetSum, int currentSum,
         int** currentPath_ptr, int* currentPathSize_ptr, int* currentPathCapacity_ptr) {
    if (node == NULL) {
        return; // Base case: If node is NULL, stop.
    }

    // Add the current node's value to the current path.
    // Check if the current path array needs to be resized.
    if (*currentPathSize_ptr == *currentPathCapacity_ptr) {
        *currentPathCapacity_ptr *= 2;
        *currentPath_ptr = (int*)realloc(*currentPath_ptr, sizeof(int) * (*currentPathCapacity_ptr));
    }
    (*currentPath_ptr)[(*currentPathSize_ptr)++] = node->val;
    currentSum += node->val;

    // If the current node is a leaf, check if the path sum matches targetSum.
    if (node->left == NULL && node->right == NULL) {
        if (currentSum == targetSum) {
            addPath(*currentPath_ptr, *currentPathSize_ptr);
        }
    } else {
        // If not a leaf, recurse for left and right children.
        dfs(node->left, targetSum, currentSum, currentPath_ptr, currentPathSize_ptr, currentPathCapacity_ptr);
        dfs(node->right, targetSum, currentSum, currentPath_ptr, currentPathSize_ptr, currentPathCapacity_ptr);
    }

    // Backtrack: remove the last element from the current path.
    // This is achieved by simply decrementing the size, effectively ignoring the last element
    // for subsequent path explorations from parent nodes.
    (*currentPathSize_ptr)--;
}

int** pathSum(struct TreeNode* root, int targetSum, int* returnSize, int** returnColumnSizes) {
    // Initialize global result variables with an initial capacity.
    g_resultCapacity = 10; // Starting capacity for storing paths
    g_result = (int**)malloc(sizeof(int*) * g_resultCapacity);
    g_returnColumnSizes = (int*)malloc(sizeof(int) * g_resultCapacity);
    g_returnSize = 0; // No paths found initially

    // Initialize variables for the current path being explored during DFS.
    int currentPathCapacity = 10; // Starting capacity for a single path
    int* currentPath = (int*)malloc(sizeof(int) * currentPathCapacity);
    int currentPathSize = 0; // Current size of the path

    // Start the DFS traversal from the root.
    dfs(root, targetSum, 0, &currentPath, &currentPathSize, &currentPathCapacity);

    // Free the temporary currentPath array used during DFS.
    free(currentPath);

    // Set the output parameters required by LeetCode.
    *returnSize = g_returnSize;
    *returnColumnSizes = g_returnColumnSizes;

    // If no paths were found, free the initial allocations for g_result and g_returnColumnSizes
    // and return NULL as per typical LeetCode conventions for empty results.
    if (g_returnSize == 0) {
        free(g_result);
        free(g_returnColumnSizes);
        *returnColumnSizes = NULL;
        return NULL;
    } else {
        // Shrink the global result arrays to their actual size to optimize memory usage.
        g_result = (int**)realloc(g_result, sizeof(int*) * g_returnSize);
        g_returnColumnSizes = (int*)realloc(g_returnColumnSizes, sizeof(int) * g_returnSize);
    }

    // Return the array of paths.
    return g_result;
}