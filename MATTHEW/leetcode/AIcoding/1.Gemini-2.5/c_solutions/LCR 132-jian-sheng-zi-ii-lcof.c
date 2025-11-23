#include <stdlib.h> // For malloc, free

long long max(long long a, long long b) {
    return a > b ? a : b;
}

int cutBamboo(int n) {
    if (n == 2) {
        return 1;
    }
    if (n == 3) {
        return 2;
    }

    long long* dp = (long long*)malloc((n + 1) * sizeof(long long));

    // dp[i] stores the maximum product for breaking integer i into at least two positive integers.
    // Base cases for DP
    dp[0] = 0; // Not used in this problem's context
    dp[1] = 0; // Cannot break 1 into at least two parts
    dp[2] = 1; // 2 = 1 + 1, product = 1
    dp[3] = 2; // 3 = 1 + 2, product = 2

    for (int i = 4; i <= n; ++i) {
        dp[i] = 0; // Initialize for current i
        // Iterate through all possible first cuts 'j'
        // 'j' can range from 1 up to i/2 to avoid redundant calculations (e.g., 1*3 is same as 3*1)
        for (int j = 1; j <= i / 2; ++j) {
            // Option 1: Break 'i' into 'j' and '(i-j)', where '(i-j)' is not broken further.
            // In this case, '(i-j)' contributes its value directly.
            long long product_no_further_break = (long long)j * (i - j);

            // Option 2: Break 'i' into 'j' and '(i-j)', where '(i-j)' is broken further optimally.
            // In this case, '(i-j)' contributes dp[i-j].
            long long product_with_further_break = (long long)j * dp[i - j];

            // Update dp[i] with the maximum product found so far
            dp[i] = max(dp[i], max(product_no_further_break, product_with_further_break));
        }
    }

    long long result = dp[n];
    free(dp); // Free allocated memory
    return (int)result; // Cast to int, assuming the final result fits within int's range.
}