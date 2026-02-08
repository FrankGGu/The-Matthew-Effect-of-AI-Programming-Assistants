class Solution {
    public int maxFrequencyAfterOperation(int[] nums) {
        int n = nums.length;
        if (n == 0) return 0;
        int[] left = new int[n];
        int[] right = new int[n];

        left[0] = 1;
        for (int i = 1; i < n; i++) {
            if (nums[i] == nums[i - 1]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 1;
            }
        }

        right[n - 1] = 1;
        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] == nums[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 1;
            }
        }

        int maxFreq = 1;
        for (int i = 0; i < n; i++) {
            int current = 1;
            if (i > 0 && i < n - 1 && nums[i - 1] == nums[i + 1]) {
                current = left[i - 1] + right[i + 1] + 1;
            } else {
                if (i > 0) {
                    current = Math.max(current, left[i - 1] + 1);
                }
                if (i < n - 1) {
                    current = Math.max(current, right[i + 1] + 1);
                }
            }
            maxFreq = Math.max(maxFreq, current);
        }

        return maxFreq;
    }
}