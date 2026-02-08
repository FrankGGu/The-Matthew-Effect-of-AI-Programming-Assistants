public class Solution {

import java.util.*;

public class Solution {
    public int maxScore(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                dp[i][j] = gcd(nums[i], nums[j]);
            }
        }

        int[][] memo = new int[n][n];
        return dfs(nums, 0, n - 1, memo, dp);
    }

    private int dfs(int[] nums, int left, int right, int[][] memo, int[][] dp) {
        if (left >= right) return 0;
        if (memo[left][right] != 0) return memo[left][right];

        int res = 0;
        for (int i = left; i < right; i++) {
            int score = dp[left][i] * (i - left + 1) + dfs(nums, left, i, memo, dp);
            score += dp[i + 1][right] * (right - i) + dfs(nums, i + 1, right, memo, dp);
            res = Math.max(res, score);
        }

        memo[left][right] = res;
        return res;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
}