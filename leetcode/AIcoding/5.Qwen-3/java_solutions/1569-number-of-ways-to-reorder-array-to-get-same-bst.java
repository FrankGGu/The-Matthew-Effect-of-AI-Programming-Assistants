public class Solution {

import java.util.*;

public class Solution {
    public int numOfWays(int[] nums) {
        return (int) dfs(nums)[1] - 1;
    }

    private long[] dfs(int[] nums) {
        if (nums.length <= 1) {
            return new long[]{1, 1};
        }
        int root = nums[0];
        List<Integer> left = new ArrayList<>();
        List<Integer> right = new ArrayList<>();
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] < root) {
                left.add(nums[i]);
            } else {
                right.add(nums[i]);
            }
        }
        int[] leftArr = new int[left.size()];
        for (int i = 0; i < left.size(); i++) {
            leftArr[i] = left.get(i);
        }
        int[] rightArr = new int[right.size()];
        for (int i = 0; i < right.size(); i++) {
            rightArr[i] = right.get(i);
        }
        long[] leftRes = dfs(leftArr);
        long[] rightRes = dfs(rightArr);
        long ways = comb(left.size() + right.size(), left.size()) * leftRes[1] % Integer.MAX_VALUE * rightRes[1] % Integer.MAX_VALUE;
        return new long[]{(leftRes[0] + rightRes[0] + 1) % Integer.MAX_VALUE, ways};
    }

    private long comb(int n, int k) {
        long[][] dp = new long[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1;
            dp[i][i] = 1;
        }
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j < i && j <= k; j++) {
                dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j];
            }
        }
        return dp[n][k];
    }
}
}