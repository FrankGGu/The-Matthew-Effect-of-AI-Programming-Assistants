class Solution {
    public boolean canBeSplit(int[] nums) {
        int n = nums.length;

        if (n < 2) {
            return false;
        }

        boolean[] prefixIncreasing = new boolean[n];
        prefixIncreasing[0] = true;
        for (int i = 1; i < n; i++) {
            prefixIncreasing[i] = prefixIncreasing[i - 1] && (nums[i] > nums[i - 1]);
        }

        boolean[] suffixIncreasing = new boolean[n];
        suffixIncreasing[n - 1] = true;
        for (int i = n - 2; i >= 0; i--) {
            suffixIncreasing[i] = suffixIncreasing[i + 1] && (nums[i] < nums[i + 1]);
        }

        for (int i = 0; i < n - 1; i++) {
            if (prefixIncreasing[i] && suffixIncreasing[i + 1]) {
                return true;
            }
        }

        return false;
    }
}