import java.util.Arrays;

class Solution {
    public int countWays(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int count = 0;

        if (nums[0] > 0) {
            count++;
        }

        for (int i = 0; i < n; i++) {
            if (i + 1 > nums[i] && (i == n - 1 || i + 1 < nums[i + 1])) {
                count++;
            }
        }

        return count;
    }
}