import java.util.Arrays;

class Solution {
    private int[][] memo;
    private int[] nums;
    private int targetScore;

    private int solve(int left, int right) {
        if (left >= right) {
            return 0;
        }
        if (memo[left][right] != -1) {
            return memo[left][right];
        }

        int maxOps = 0;

        // Option 1: Pick nums[left] and nums[left+1]
        if (left + 1 <= right && nums[left] + nums[left+1] == targetScore) {
            maxOps = Math.max(maxOps, 1 + solve(left + 2, right));
        }

        // Option 2: Pick nums[left] and nums[right]
        if (nums[left] + nums[right] == targetScore) {
            maxOps = Math.max(maxOps, 1 + solve(left + 1, right - 1));
        }

        // Option 3: Pick nums[right-1] and nums[right]
        if (right - 1 >= left && nums[right-1] + nums[right] == targetScore) {
            maxOps = Math.max(maxOps, 1 + solve(left, right - 2));
        }

        return memo[left][right] = maxOps;
    }

    public int maxOperations(int[] nums) {
        this.nums = nums;
        int n = nums.length;
        int maxOverallOps = 0;

        // Case 1: First operation uses nums[0] and nums[1]
        this.targetScore = nums[0] + nums[1];
        memo = new int[n][n];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        maxOverallOps = Math.max(maxOverallOps, 1 + solve(2, n - 1));

        // Case 2: First operation uses nums[0] and nums[n-1]
        this.targetScore = nums[0] + nums[n-1];
        memo = new int[n][n];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        maxOverallOps = Math.max(maxOverallOps, 1 + solve(1, n - 2));

        // Case 3: First operation uses nums[n-2] and nums[n-1]
        this.targetScore = nums[n-2] + nums[n-1];
        memo = new int[n][n];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        maxOverallOps = Math.max(maxOverallOps, 1 + solve(0, n - 3));

        return maxOverallOps;
    }
}