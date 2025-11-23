import java.util.Arrays;

class Solution {
    public long countFairPairs(int[] nums, int lower, int upper) {
        Arrays.sort(nums);
        long count = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            long targetLower = (long) lower - nums[i];
            long targetUpper = (long) upper - nums[i];

            int idx1 = lowerBound(nums, i + 1, n, targetLower);
            int idx2 = upperBound(nums, i + 1, n, targetUpper);

            count += (idx2 - idx1);
        }

        return count;
    }

    private int lowerBound(int[] nums, int fromIndex, int toIndex, long target) {
        int low = fromIndex;
        int high = toIndex;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (nums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    private int upperBound(int[] nums, int fromIndex, int toIndex, long target) {
        int low = fromIndex;
        int high = toIndex;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (nums[mid] <= target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
}