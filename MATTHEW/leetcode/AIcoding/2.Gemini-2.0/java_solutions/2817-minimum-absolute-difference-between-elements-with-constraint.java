import java.util.Arrays;

class Solution {
    public int minAbsoluteDifference(int[] nums, int x) {
        int n = nums.length;
        int minDiff = Integer.MAX_VALUE;
        TreeSet<Integer> set = new TreeSet<>();

        for (int i = x; i < n; i++) {
            set.add(nums[i - x]);
            Integer lower = set.floor(nums[i]);
            Integer higher = set.ceiling(nums[i]);

            if (lower != null) {
                minDiff = Math.min(minDiff, Math.abs(nums[i] - lower));
            }
            if (higher != null) {
                minDiff = Math.min(minDiff, Math.abs(nums[i] - higher));
            }
        }

        return minDiff;
    }
}