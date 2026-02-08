class Solution {
    public long countFairPairs(int[] nums, int lower, int upper) {
        Arrays.sort(nums);
        long count = 0;
        for (int i = 0; i < nums.length; i++) {
            int left = i + 1;
            int right = nums.length - 1;
            int lowerBound = lower - nums[i];
            int upperBound = upper - nums[i];
            int start = findFirstGreaterOrEqual(nums, left, right, lowerBound);
            int end = findLastLessOrEqual(nums, left, right, upperBound);
            if (start <= end) {
                count += (end - start + 1);
            }
        }
        return count;
    }

    private int findFirstGreaterOrEqual(int[] nums, int left, int right, int target) {
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] >= target) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private int findLastLessOrEqual(int[] nums, int left, int right, int target) {
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return right;
    }
}