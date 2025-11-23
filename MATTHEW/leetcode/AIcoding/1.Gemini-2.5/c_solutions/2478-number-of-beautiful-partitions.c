#include <stdbool.h>
#include <string.h>
#include <stdlib.h> // For malloc, calloc, free

bool is_prime_digit(char c) {
    return c == '2' || c == '3' || c == '5' || c == '7';
}

bool is_non_prime_digit(char c) {
    return c == '0' || c == '1' || c == '4' || c == '6' || c == '8' || c == '9';
}

int beautifulPartitions(char* s, int k) {
    int n = strlen(s);
    long long MOD = 1e9 + 7;

    // Initial checks based on problem constraints and definition of beautiful partitions
    // 1. The first character of s must be a prime digit.
    // 2. The last character of s must be a non-prime digit.
    if (!is_prime_digit(s[0]) || !is_non_prime_digit(s[n - 1])) {
        return 0;
    }
    // 3. Each substring must have a length of at least 2 (starts with prime, ends with non-prime).
    // Therefore, k partitions require a minimum total length of 2*k characters.
    if (k * 2 > n) {
        return 0;
    }

    // dp[i][j] will store the number of ways to partition
    // the prefix s[0...i-1] into j beautiful substrings.
    // 'i' ranges from 0 to n (representing the length of the prefix)
    // 'j' ranges from 0 to k (representing the number of partitions)
    long long** dp = (long long**)malloc((n + 1) * sizeof(long long*));
    for (int i = 0; i <= n; ++i) {
        dp[i] = (long long*)calloc((k + 1), sizeof(long long));
    }

    // Base case: An empty prefix (length 0) can be partitioned into 0 substrings in 1 way (the empty partition).
    dp[0][0] = 1;

    // Iterate through the number of partitions 'j' from 1 to k
    for (int j = 1; j <= k; ++j) {
        // sum_dp_prev_j_prime_start will accumulate dp[p][j-1] for p such that s[p] is a prime digit.
        // This sum represents the number of ways to form j-1 partitions ending at s[p-1],
        // where s[p] is a potential starting character for the j-th partition.
        // The j-th partition s[p...i-1] must have a length of at least 2, meaning p <= i-2.
        // So, sum_dp_prev_j_prime_start needs to contain dp[x][j-1] for x up to i-2.
        long long sum_dp_prev_j_prime_start = 0;

        // Iterate through prefix lengths 'i' from 1 to n
        for (int i = 1; i <= n; ++i) {
            // Update sum_dp_prev_j_prime_start for the current 'i'.
            // For dp[i][j], the last segment ends at s[i-1].
            // This segment could have started at s[p], where p <= i-2.
            // So, we need to add dp[i-2][j-1] to the sum if s[i-2] is a prime digit.
            // This update happens before dp[i][j] is calculated, ensuring sum_dp_prev_j_prime_start
            // holds values for x up to i-2.
            if (i >= 2 && is_prime_digit(s[i - 2])) {
                sum_dp_prev_j_prime_start = (sum_dp_prev_j_prime_start + dp[i - 2][j - 1]) % MOD;
            }

            // If the current character s[i-1] is a non-prime digit,
            // a beautiful partition can potentially end at this position.
            if (is_non_prime_digit(s[i - 1])) {
                dp[i][j] = sum_dp_prev_j_prime_start;
            }
        }
    }

    long long result = dp[n][k];

    // Free allocated memory to prevent memory leaks
    for (int i = 0; i <= n; ++i) {
        free(dp[i]);
    }
    free(dp);

    return (int)result;
}