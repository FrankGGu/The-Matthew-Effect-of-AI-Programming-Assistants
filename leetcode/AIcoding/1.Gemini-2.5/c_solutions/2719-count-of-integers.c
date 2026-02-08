#include <string.h>
#include <stdlib.h> // For malloc, free, strdup
#include <stdbool.h>

long long dp[24][220][2][2]; 
char S_str[24]; // Stores the number string for the current countS call
int MAX_SUM_GLOBAL;
const int MOD = 1e9 + 7;

long long dfs(int idx, int current_sum, bool is_less, bool is_leading_zero) {
    // Pruning: If current_sum already exceeds MAX_SUM_GLOBAL, this path is invalid
    if (current_sum > MAX_SUM_GLOBAL) {
        return 0;
    }

    // Base case: If we have processed all digits
    if (idx == strlen(S_str)) {
        // If we reached the end, it means we formed a valid number
        // (its sum is <= MAX_SUM_GLOBAL, checked by the pruning step)
        return 1;
    }

    // Memoization: If this state has been computed before, return the stored result
    if (dp[idx][current_sum][is_less][is_leading_zero] != -1) {
        return dp[idx][current_sum][is_less][is_leading_zero];
    }

    long long ans = 0;
    // Determine the upper bound for the current digit
    // If is_less is true, we can place any digit from 0-9.
    // Otherwise, we are restricted by the digit in S_str[idx].
    int upper_bound = is_less ? 9 : (S_str[idx] - '0');

    for (int digit = 0; digit <= upper_bound; ++digit) {
        if (is_leading_zero && digit == 0) {
            // If we are still placing leading zeros and the current digit is 0,
            // the sum remains 0, and we continue in the is_leading_zero state.
            ans = (ans + dfs(idx + 1, 0, is_less || (digit < upper_bound), true)) % MOD;
        } else {
            // If we placed a non-zero digit (or are no longer in leading zero state),
            // update the sum and transition out of is_leading_zero state.
            ans = (ans + dfs(idx + 1, current_sum + digit, is_less || (digit < upper_bound), false)) % MOD;
        }
    }

    // Store and return the result for the current state
    return dp[idx][current_sum][is_less][is_leading_zero] = ans;
}

long long countS(char* s, int max_sum) {
    strcpy(S_str, s);
    MAX_SUM_GLOBAL = max_sum;

    // Initialize DP table with -1 for memoization
    memset(dp, -1, sizeof(dp));

    // Start DFS from index 0, current_sum 0, not restricted by upper bound yet, and in leading_zero state
    return dfs(0, 0, false, true);
}

char* subtractOne(char* num_str) {
    int n = strlen(num_str);
    char* res = (char*)malloc(sizeof(char) * (n + 1));
    strcpy(res, num_str);

    // Handle the special case where num_str is "0"
    if (strcmp(num_str, "0") == 0) {
        free(res); // Free the initially allocated memory
        return strdup("-1"); // Indicate that there's no non-negative predecessor
    }

    int i = n - 1;
    // Propagate borrow from right to left
    while (i >= 0 && res[i] == '0') {
        res[i] = '9';
        i--;
    }

    // Decrement the first non-zero digit found (or the first digit if no zeros)
    res[i]--;

    // The dfs function can handle leading zeros (e.g., "100" -> "099"), so no need to trim.
    return res;
}

int countRestrictedIntegers(char* num1, char* num2, int max_sum) {
    // Count numbers up to num2 (inclusive)
    long long ans2 = countS(num2, max_sum);

    // Calculate num1 - 1 as a string
    char* num1_minus_1 = subtractOne(num1);
    long long ans1_minus_1;

    // If num1_minus_1 is "-1", it means num1 was "0", so count(num1-1) is 0
    if (strcmp(num1_minus_1, "-1") == 0) {
        ans1_minus_1 = 0;
    } else {
        // Count numbers up to num1 - 1 (inclusive)
        ans1_minus_1 = countS(num1_minus_1, max_sum);
    }

    // Free the dynamically allocated string for num1_minus_1
    free(num1_minus_1); 

    // The result is (count up to num2) - (count up to num1-1)
    // Add MOD before taking modulo to handle potential negative results from subtraction
    long long final_ans = (ans2 - ans1_minus_1 + MOD) % MOD;

    return (int)final_ans;
}