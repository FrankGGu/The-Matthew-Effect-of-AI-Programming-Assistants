class Solution {
    public int countImmovableSubarrays(int[] nums) {
        int n = nums.length;
        int[] left = new int[n];
        int[] right = new int[n];

        for (int i = 0; i < n; i++) {
            if (i == 0 || nums[i] >= nums[i - 1]) {
                left[i] = (i == 0 ? 0 : left[i - 1]) + 1;
            } else {
                left[i] = 1;
            }
        }

        for (int i = n - 1; i >= 0; i--) {
            if (i == n - 1 || nums[i] <= nums[i + 1]) {
                right[i] = (i == n - 1 ? 0 : right[i + 1]) + 1;
            } else {
                right[i] = 1;
            }
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            count += left[i] + right[i] - 1;
        }

        return count;
    }
}