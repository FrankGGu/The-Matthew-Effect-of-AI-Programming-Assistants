#include <stdlib.h> // For malloc, qsort
#include <string.h> // For memset

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int kthLargestValue(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int m = matrixSize;
    int n = matrixColSize[0];

    // dp table to store XOR sums for rectangles ending at (i-1, j-1)
    // dp[i][j] will store the XOR sum of the rectangle from (0,0) to (i-1, j-1)
    // The table is (m+1) x (n+1) to handle base cases easily (dp[0][j] and dp[i][0] are implicitly 0)
    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; ++i) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
        // Initialize the first row and column of dp to 0.
        // memset sets the entire row to 0, which covers dp[i][0] and dp[0][j] correctly.
        memset(dp[i], 0, (n + 1) * sizeof(int));
    }

    // Array to store all m*n XOR coordinate values
    int* xor_values = (int*)malloc(m * n * sizeof(int));
    int count = 0;

    // Calculate XOR coordinate values using dynamic programming
    for (int i = 1; i <= m; ++i) {
        for (int j = 1; j <= n; ++j) {
            // dp[i][j] = matrix[i-1][j-1] ^ dp[i-1][j] ^ dp[i][j-1] ^ dp[i-1][j-1]
            dp[i][j] = matrix[i-1][j-1] ^ dp[i-1][j] ^ dp[i][j-1] ^ dp[i-1][j-1];
            xor_values[count++] = dp[i][j];
        }
    }

    // Sort the xor_values array in descending order
    qsort(xor_values, m * n, sizeof(int), compare);

    // The Kth largest value is at index k-1 (0-indexed)
    int result = xor_values[k - 1];

    // Free allocated memory
    for (int i = 0; i <= m; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(xor_values);

    return result;
}