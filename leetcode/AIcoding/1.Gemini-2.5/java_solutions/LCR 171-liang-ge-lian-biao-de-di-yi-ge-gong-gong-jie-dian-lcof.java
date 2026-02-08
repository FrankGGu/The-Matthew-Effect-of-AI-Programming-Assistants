import java.util.Arrays;

class Solution {
    private int[][] memo;
    private int[] nums;
    private int target;

    public int maxOperations(int[] nums) {
        this.nums = nums;
        int n = nums.length;
        if (n < 2) {
            return 0;
        }

        int maxOps = 0;

        target = nums[0] + nums[1];
        memo = new int[n][n];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        maxOps = Math.max(maxOps, 1 + solve(2, n - 1));

        target = nums[n - 2] + nums[n - 1];
        memo = new int[n][n];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        maxOps = Math.max(maxOps, 1 + solve(0, n - 3));

        target = nums[0] + nums[n - 1];
        memo = new int[n][n];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        maxOps = Math.max(maxOps, 1 + solve(1, n - 2));

        return maxOps;
    }

    private int solve(int left, int right) {
        if (left >= right) {
            return 0;
        }
        if (memo[left][right] != -1) {
            return memo[left][right];
        }

        int res = 0;
        if (left + 1 <= right && nums[left] + nums[left + 1] == target) {
            res = Math.max(res, 1 + solve(left + 2, right));
        }
        if (right - 1 >= left && nums[right - 1] + nums[right] == target) {
            res = Math.max(res, 1 + solve(left, right - 2));
        }
        if (nums[left] + nums[right] == target) {
            res = Math.max(res, 1 + solve(left + 1, right - 1));
        }

        return memo[left][right] = res;
    }
}