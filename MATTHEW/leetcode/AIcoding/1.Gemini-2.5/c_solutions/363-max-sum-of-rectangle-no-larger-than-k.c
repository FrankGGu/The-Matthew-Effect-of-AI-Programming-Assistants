#include <stdlib.h>
#include <limits.h>
#include <string.h> // For memset

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* createNode(int val) {
    TreeNode* newNode = (TreeNode*)malloc(sizeof(TreeNode));
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

TreeNode* insert(TreeNode* root, int val) {
    if (root == NULL) {
        return createNode(val);
    }
    if (val < root->val) {
        root->left = insert(root->left, val);
    } else if (val > root->val) {
        root->right = insert(root->right, val);
    }
    // If val == root->val, do nothing (duplicates are fine, just need *a* value)
    return root;
}

int getCeil(TreeNode* root, int target) {
    int ceilVal = INT_MAX; // Initialize with a value larger than any possible sum
    while (root != NULL) {
        if (root->val >= target) {
            ceilVal = root->val;
            root = root->left; // Try to find a smaller value in the left subtree
        } else {
            root = root->right; // Current node is too small, need larger values from right subtree
        }
    }
    return ceilVal;
}

void freeBST(TreeNode* root) {
    if (root != NULL) {
        freeBST(root->left);
        freeBST(root->right);
        free(root);
    }
}

int maxSumSubarrayNoLargerThanK(int* nums, int numsSize, int k) {
    int maxSum = INT_MIN;
    TreeNode* root = NULL;
    root = insert(root, 0); // Initialize with 0 for empty prefix sum

    int currentSum = 0;
    for (int i = 0; i < numsSize; ++i) {
        currentSum += nums[i];

        // Find smallest p in BST such that p >= currentSum - k
        // This means currentSum - p <= k, and we want to maximize currentSum - p,
        // which means minimizing p.
        int target = currentSum - k;
        int p = getCeil(root, target);

        if (p != INT_MAX) { // If such p exists
            if (currentSum - p > maxSum) {
                maxSum = currentSum - p;
            }
        }
        root = insert(root, currentSum);
    }
    freeBST(root);
    return maxSum;
}

int maxSumSubmatrix(int** matrix, int matrixSize, int* matrixColSize, int k) {
    if (matrixSize == 0 || matrixColSize[0] == 0) {
        return 0;
    }

    int rows = matrixSize;
    int cols = matrixColSize[0];
    int maxSum = INT_MIN;

    // Determine which dimension to iterate as outer loops to optimize
    // We want the inner 1D problem to be on the smaller dimension
    // If cols < rows, swap roles of rows and cols conceptually to optimize
    int r_dim = rows; // The dimension for the outer loops (r1, r2 or c1, c2)
    int c_dim = cols; // The dimension for the inner 1D array (cols or rows)
    int is_transposed = 0; // Flag to indicate if we're processing conceptually transposed matrix

    if (cols < rows) {
        is_transposed = 1;
        r_dim = cols; // Iterate over columns as if they were rows
        c_dim = rows; // The 1D array will be based on rows
    }

    // Allocate memory for sums array (for 1D problem)
    // This array will hold the sum of elements for the current fixed rectangle boundaries
    int* sums = (int*)malloc(c_dim * sizeof(int));
    if (sums == NULL) {
        return INT_MIN; // Should not happen given problem constraints
    }

    // Iterate over all possible top/left boundaries (r1 or c1)
    for (int i = 0; i < r_dim; ++i) {
        // Initialize sums array for each new i
        memset(sums, 0, c_dim * sizeof(int));

        // Iterate over all possible bottom/right boundaries (r2 or c2)
        for (int j = i; j < r_dim; ++j) {
            // Calculate 1D array sums for the current rectangle (between i and j)
            for (int x = 0; x < c_dim; ++x) {
                if (!is_transposed) {
                    // Original orientation: sum columns from row i to row j
                    sums[x] += matrix[j][x]; 
                } else {
                    // Transposed orientation: sum rows from column i to column j
                    sums[x] += matrix[x][j]; 
                }
            }

            // Now, sums[] is a 1D array. Find max subarray sum <= k
            int currentMax = maxSumSubarrayNoLargerThanK(sums, c_dim, k);

            if (currentMax > maxSum) {
                maxSum = currentMax;
            }
        }
    }

    free(sums);
    return maxSum;
}