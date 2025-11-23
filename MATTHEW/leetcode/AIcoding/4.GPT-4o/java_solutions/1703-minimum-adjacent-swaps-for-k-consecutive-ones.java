class Solution {
    public int minSwaps(int[] nums, int k) {
        int n = nums.length;
        int[] ones = new int[n];
        int count = 0;

        for (int num : nums) {
            if (num == 1) count++;
        }

        if (k > count) return -1;

        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int minSwaps = Integer.MAX_VALUE;
        for (int i = 0; i <= n - k; i++) {
            int onesInWindow = prefix[i + k] - prefix[i];
            if (onesInWindow == k) {
                int swaps = 0;
                for (int j = i; j < i + k; j++) {
                    if (nums[j] == 0) swaps++;
                }
                minSwaps = Math.min(minSwaps, swaps);
            }
        }

        return minSwaps;
    }
}