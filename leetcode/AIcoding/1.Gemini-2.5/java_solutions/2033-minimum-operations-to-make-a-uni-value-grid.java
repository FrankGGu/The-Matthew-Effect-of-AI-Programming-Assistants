import java.util.Arrays;

class Solution {
    public int minOperations(int[][] grid, int x) {
        int m = grid.length;
        int n = grid[0].length;

        int[] nums = new int[m * n];
        int k = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                nums[k++] = grid[i][j];
            }
        }

        int firstRemainder = nums[0] % x;
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] % x != firstRemainder) {
                return -1;
            }
        }

        Arrays.sort(nums);

        int median = nums[nums.length / 2];
        int operations = 0;
        for (int num : nums) {
            operations += Math.abs(num - median) / x;
        }

        return operations;
    }
}