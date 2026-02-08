#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MIN

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int maxDotProduct(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int m = nums1Size;
    int n = nums2Size;

    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
    }

    // Initialize dp table with a value smaller than any possible valid dot product.
    // The smallest possible product of two numbers is -1000 * 1000 = -1,000,000.
    // A value like -1,000,000,001 (less than -10^6 and greater than INT_MIN) is used
    // to avoid potential overflow issues if INT_MIN is added to a positive number,
    // and to clearly distinguish from valid (even negative) dot products.
    const int MIN_DOT_PRODUCT_INIT = -1000000001; 

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = MIN_DOT_PRODUCT_INIT;
        }
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            int current_pair_product = nums1[i-1] * nums2[j-1];

            // Option 1: Include nums1[i-1] and nums2[j-1]
            // This can either start a new subsequence pair (just current_pair_product),
            // or extend a previous one (current_pair_product + dp[i-1][j-1]).
            int val_if_both_used = current_pair_product;
            if (dp[i-1][j-1] != MIN_DOT_PRODUCT_INIT) { 
                val_if_both_used = max(val_if_both_used, current_pair_product + dp[i-1][j-1]);
            }

            // dp[i][j] is the maximum of three possibilities:
            // 1. Max dot product formed by using nums1[i-1] and nums2[j-1] (val_if_both_used)
            // 2. Max dot product without using nums1[i-1] (dp[i-1][j])
            // 3. Max dot product without using nums2[j-1] (dp[i][j-1])
            dp[i][j] = max(val_if_both_used, dp[i-1][j]);
            dp[i][j] = max(dp[i][j], dp[i][j-1]);
        }
    }

    int result = dp[m][n];

    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}