#include <stdlib.h> // Required for malloc

#define MOD 12345

int** constructProductMatrix(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    // Set returnSize and returnColumnSizes for the caller
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    // Allocate memory for the result matrix
    int** result = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
    }

    // Handle edge case of an empty grid or zero-sized dimensions
    if (m == 0 || n == 0) {
        return result;
    }

    // First pass: Calculate prefix products (from left to right, top to bottom)
    // and store them temporarily in the result matrix.
    // result[i][j] will store the product of all elements *before* grid[i][j] in row-major order.
    long long current_product_left = 1;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = current_product_left;
            current_product_left = (current_product_left * grid[i][j]) % MOD;
        }
    }

    // Second pass: Calculate suffix products (from right to left, bottom to top)
    // and combine them with the stored prefix products to get the final result.
    long long current_product_right = 1;
    for (int i = m - 1; i >= 0; i--) {
        for (int j = n - 1; j >= 0; j--) {
            // result[i][j] currently holds the product of elements before grid[i][j]
            // Multiply it by the product of elements after grid[i][j] (current_product_right)
            result[i][j] = (result[i][j] * current_product_right) % MOD;

            // Update current_product_right for the next iteration
            current_product_right = (current_product_right * grid[i][j]) % MOD;
        }
    }

    return result;
}