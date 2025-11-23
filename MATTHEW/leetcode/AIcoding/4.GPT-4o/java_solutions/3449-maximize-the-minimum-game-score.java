class Solution {
    public int maximizeMinimum(int[] nums, int p) {
        int n = nums.length;
        Arrays.sort(nums);
        int left = 0, right = nums[n - 1];

        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (canAchieve(nums, mid, p)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        return left;
    }

    private boolean canAchieve(int[] nums, int minValue, int p) {
        int count = 0, i = 0;
        while (i < nums.length) {
            if (nums[i] >= minValue) {
                count++;
                i += 2; // Skip the next element as we form a pair
            } else {
                i++;
            }
        }
        return count >= p;
    }
}