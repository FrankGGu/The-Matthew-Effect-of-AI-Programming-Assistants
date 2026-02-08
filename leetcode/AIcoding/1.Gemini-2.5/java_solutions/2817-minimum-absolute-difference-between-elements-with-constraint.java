import java.util.TreeSet;

class Solution {
    public int minAbsoluteDifference(int[] nums, int x) {
        int minDiff = Integer.MAX_VALUE;
        TreeSet<Integer> set = new TreeSet<>();

        for (int i = 0; i < nums.length; i++) {
            if (i - x >= 0) {
                set.add(nums[i - x]);
            }

            if (!set.isEmpty()) {
                // Find the smallest element in set that is greater than or equal to nums[i]
                Integer ceiling = set.ceiling(nums[i]);
                if (ceiling != null) {
                    minDiff = Math.min(minDiff, Math.abs(nums[i] - ceiling));
                }

                // Find the largest element in set that is less than or equal to nums[i]
                Integer floor = set.floor(nums[i]);
                if (floor != null) {
                    minDiff = Math.min(minDiff, Math.abs(nums[i] - floor));
                }
            }
        }

        return minDiff;
    }
}