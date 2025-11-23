import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minOperations(int[][] grid, int x) {
        int m = grid.length;
        int n = grid[0].length;
        List<Integer> nums = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                nums.add(grid[i][j]);
            }
        }
        Collections.sort(nums);
        int median = nums.get(nums.size() / 2);
        int operations = 0;
        for (int num : nums) {
            int diff = Math.abs(num - median);
            if (diff % x != 0) {
                return -1;
            }
            operations += diff / x;
        }
        return operations;
    }
}