#include <string.h> // Required for memset, though manual loop is used for DP table initialization

#define MAX_DIGITS 19 
#define MAX_SUM 163 

long long dp[MAX_DIGITS][2][MAX_SUM][MAX_SUM];

int digits_arr[MAX_DIGITS];
int num_len;
int current_k;

long long count_recursive(int idx, int tight, int current_sum, int current_rem, int is_leading_zero) {
    // Optimization: If the current sum already exceeds the target sum, no valid number can be formed.
    if (current_sum > current_k) {
        return 0;
    }

    // Base case: All digits have been processed.
    if (idx == num_len) {
        // A number is beautiful if:
        // 1. It's not a sequence of only leading zeros (i.e., not an empty number or 0 itself).
        // 2. Its sum of digits equals current_k.
        // 3. The number itself is divisible by current_k (current_rem == 0).
        return (!is_leading_zero && current_sum == current_k && current_rem == 0) ? 1 : 0;
    }

    // Memoization: If not placing leading zeros and not restricted by the tight constraint,
    // the result for this state has already been computed and can be returned.
    if (!is_leading_zero && !tight && dp[idx][tight][current_sum][current_rem] != -1) {
        return dp[idx][tight][current_sum][current_rem];
    }

    long long ans = 0;
    // Determine the upper limit for the current digit.
    // If 'tight' is 1, the digit cannot exceed digits_arr[idx].
    // Otherwise, it can be any digit from 0 to 9.
    int upper_bound = tight ? digits_arr[idx] : 9;

    for (int digit = 0; digit <= upper_bound; digit++) {
        if (is_leading_zero && digit == 0) {
            // If we are currently placing leading zeros and the current digit is 0,
            // the sum and remainder remain 0, and we continue in the 'is_leading_zero' state.
            ans += count_recursive(idx + 1, tight && (digit == upper_bound), 0, 0, 1);
        } else {
            // If the number has started (or starts now with a non-zero digit),
            // update the sum and remainder, and set 'is_leading_zero' to 0.
            ans += count_recursive(idx + 1, tight && (digit == upper_bound),
                                   current_sum + digit,
                                   (current_rem * 10 + digit) % current_k,
                                   0);
        }
    }

    // Store the computed result in the DP table if it's a memoizable state.
    if (!is_leading_zero && !tight) {
        dp[idx][tight][current_sum][current_rem] = ans;
    }

    return ans;
}

void num_to_digits(long long n) {
    num_len = 0;
    if (n == 0) {
        digits_arr[0] = 0;
        num_len = 1;
        return;
    }
    long long temp_n = n;
    while (temp_n > 0) {
        digits_arr[num_len++] = temp_n % 10;
        temp_n /= 10;
    }
    // Reverse the digits_arr to have the most significant digit at index 0.
    for (int i = 0; i < num_len / 2; i++) {
        int temp = digits_arr[i];
        digits_arr[i] = digits_arr[num_len - 1 - i];
        digits_arr[num_len - 1 - i] = temp;
    }
}

long long countBeautifulNumbers(long long n) {
    num_to_digits(n); // Convert N into its digits array for DP processing.

    long long total_beautiful_count = 0;
    // Iterate through all possible sums of digits (k).
    // For N up to 10^18, the maximum sum of digits is 9 * 18 = 162.
    // We check for k from 1 up to 162.
    for (int k = 1; k <= 162; k++) {
        current_k = k; // Set the target sum for the current iteration.

        // Initialize the DP table with -1 for each new value of 'k'.
        // -1 indicates that the state has not yet been computed.
        for (int i = 0; i < MAX_DIGITS; i++) {
            for (int j = 0; j < 2; j++) {
                for (int l = 0; l < MAX_SUM; l++) {
                    for (int m = 0; m < MAX_SUM; m++) {
                        dp[i][j][l][m] = -1;
                    }
                }
            }
        }
        // Call the recursive function to count numbers up to N that satisfy
        // the condition: sum of digits equals 'k' AND the number is divisible by 'k'.
        total_beautiful_count += count_recursive(0, 1, 0, 0, 1);
    }

    return total_beautiful_count;
}