import java.math.BigInteger;
import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int MAX_POSSIBLE_DIGIT_SUM = 22 * 9; // Max length of num is 22, max digit sum is 22 * 9 = 198.

    private String s;
    private int min_sum_target;
    private int max_sum_target;
    private long[][][][] memo; // [index][current_sum][tight][is_leading]

    public int count(String num1, String num2, int min_sum, int max_sum) {
        this.min_sum_target = min_sum;
        this.max_sum_target = max_sum;

        long ans2 = calculate(num2);
        long ans1_minus_1 = calculate(subtractOne(num1));

        return (int)((ans2 - ans1_minus_1 + MOD) % MOD);
    }

    private long calculate(String num) {
        s = num;
        // memo[index][current_sum][tight_flag][is_leading_flag]
        memo = new long[s.length()][MAX_POSSIBLE_DIGIT_SUM + 1][2][2];
        for (long[][][] d3 : memo) {
            for (long[][] d2 : d3) {
                for (long[] d1 : d2) {
                    Arrays.fill(d1, -1L);
                }
            }
        }
        return dfs(0, 0, true, true);
    }

    private long dfs(int index, int current_sum, boolean tight, boolean is_leading) {
        // Pruning: If current sum already exceeds max_sum_target, this path cannot lead to a valid number.
        if (current_sum > max_sum_target) {
            return 0;
        }

        // Base case: If we have processed all digits
        if (index == s.length()) {
            // If `is_leading` is true, it means the number formed was effectively 0 (e.g., "0", "00").
            // Since problem states num1 and num2 are positive, x must be positive. So 0 is not counted.
            if (is_leading) {
                return 0;
            }
            // Otherwise, a non-zero number was formed. Check if its sum is within the target range.
            return (current_sum >= min_sum_target && current_sum <= max_sum_target) ? 1 : 0;
        }

        // Memoization check
        if (memo[index][current_sum][tight ? 1 : 0][is_leading ? 1 : 0] != -1) {
            return memo[index][current_sum][tight ? 1 : 0][is_leading ? 1 : 0];
        }

        long ans = 0;
        int upper_bound = tight ? (s.charAt(index) - '0') : 9;

        for (int digit = 0; digit <= upper_bound; digit++) {
            if (is_leading && digit == 0) {
                // Still placing leading zeros, current_sum does not change
                ans = (ans + dfs(index + 1, current_sum, tight && (digit == upper_bound), true)) % MOD;
            } else {
                // Placed a non-zero digit, or already placed a non-zero digit earlier
                // current_sum increases by digit
                ans = (ans + dfs(index + 1, current_sum + digit, tight && (digit == upper_bound), false)) % MOD;
            }
        }

        return memo[index][current_sum][tight ? 1 : 0][is_leading ? 1 : 0] = ans;
    }

    // Helper function to subtract one from a number represented as a string
    private String subtractOne(String num) {
        BigInteger b = new BigInteger(num);
        b = b.subtract(BigInteger.ONE);
        return b.toString();
    }
}