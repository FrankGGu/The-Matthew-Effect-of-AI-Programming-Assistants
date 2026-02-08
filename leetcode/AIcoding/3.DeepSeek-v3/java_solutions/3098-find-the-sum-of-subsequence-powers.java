import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    private static final int MOD = 1_000_000_007;
    private int[] nums;
    private int k;
    private int[][] dp;

    public int sumOfPowers(int[] nums, int k) {
        Arrays.sort(nums);
        this.nums = nums;
        this.k = k;
        this.dp = new int[nums.length][k + 1];
        for (int[] row : dp) {
            Arrays.fill(row, -1);
        }
        int result = 0;
        for (int i = 0; i < nums.length; i++) {
            result = (result + dfs(i, 1, Integer.MAX_VALUE)) % MOD;
        }
        return result;
    }

    private int dfs(int pos, int count, int minDiff) {
        if (count == k) {
            return minDiff;
        }
        if (dp[pos][count] != -1 && minDiff == Integer.MAX_VALUE) {
            return dp[pos][count];
        }
        int res = 0;
        for (int i = pos + 1; i < nums.length; i++) {
            int newDiff = Math.min(minDiff, nums[i] - nums[pos]);
            res = (res + dfs(i, count + 1, newDiff)) % MOD;
        }
        if (minDiff == Integer.MAX_VALUE) {
            dp[pos][count] = res;
        }
        return res;
    }
}