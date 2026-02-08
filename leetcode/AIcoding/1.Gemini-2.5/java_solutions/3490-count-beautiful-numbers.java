import java.util.Arrays;

class Solution {
    long[][][][][] memo;
    char[] s_arr;

    public int countBeautifulNumbers(int low, int high) {
        return (int) (solve(high) - solve(low - 1));
    }

    private long solve(int n) {
        s_arr = String.valueOf(n).toCharArray();
        long totalBeautiful = 0;

        // The maximum sum of digits for a number up to 10^9 (e.g., 999,999,999) is 9 * 9 = 81.
        // For 1,000,000,000, the sum is 1.
        // So, the target sum of digits can range from 1 to 81.
        for (int targetSum = 1; targetSum <= 81; targetSum++) {
            // Initialize memoization table for each targetSum.
            // Dimensions: index, currentSum, currentMod, tight, isLeadingZero
            // index: up to s_arr.length (max 10 for 10^9)
            // currentSum: up to targetSum (max 81)
            // currentMod: up to targetSum - 1 (max 80)
            // tight: 0 or 1
            // isLeadingZero: 0 or 1
            memo = new long[s_arr.length + 1][targetSum + 1][targetSum][2][2];
            for (long[][][][] m1 : memo) {
                for (long[][][] m2 : m1) {
                    for (long[][] m3 : m2) {
                        for (long[] m4 : m3) {
                            Arrays.fill(m4, -1);
                        }
                    }
                }
            }
            totalBeautiful += dfs(0, 0, 0, true, true, targetSum);
        }
        return totalBeautiful;
    }

    private long dfs(int index, int currentSum, int currentMod, boolean tight, boolean isLeadingZero, int targetSum) {
        // Base case: If we have processed all digits
        if (index == s_arr.length) {
            // A number is beautiful if its sum of digits equals targetSum AND
            // the number itself is divisible by targetSum.
            // isLeadingZero being true means no non-zero digit was placed, so it's not a valid number.
            return (isLeadingZero || currentSum != targetSum || currentMod != 0) ? 0 : 1;
        }

        // Memoization check
        if (memo[index][currentSum][currentMod][tight ? 1 : 0][isLeadingZero ? 1 : 0] != -1) {
            return memo[index][currentSum][currentMod][tight ? 1 : 0][isLeadingZero ? 1 : 0];
        }

        long ans = 0;
        int upperLimit = tight ? (s_arr[index] - '0') : 9;

        // Iterate through possible digits for the current position
        for (int digit = 0; digit <= upperLimit; digit++) {
            boolean newIsLeadingZero = isLeadingZero && (digit == 0);

            int nextCurrentSum = currentSum;
            int nextCurrentMod = currentMod;

            // Update sum and mod only if we are not placing a leading zero
            // (i.e., we are forming a real number or just started forming one).
            if (!newIsLeadingZero) {
                nextCurrentSum += digit;
                nextCurrentMod = (currentMod * 10 + digit) % targetSum;
            }

            // Pruning: If the current sum of digits already exceeds the target sum,
            // this path cannot lead to a valid beautiful number.
            if (nextCurrentSum > targetSum) {
                continue;
            }

            // Recursive call for the next digit
            ans += dfs(index + 1, nextCurrentSum, nextCurrentMod, tight && (digit == upperLimit), newIsLeadingZero, targetSum);
        }

        // Store and return the result
        return memo[index][currentSum][currentMod][tight ? 1 : 0][isLeadingZero ? 1 : 0] = ans;
    }
}