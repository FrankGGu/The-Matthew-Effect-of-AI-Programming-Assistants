class Solution {
    public int minimumMountainRemovals(int[] nums) {
        int n = nums.length;
        int[] inc = new int[n];
        int[] dec = new int[n];

        for (int i = 0; i < n; i++) {
            inc[i] = 1;
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    inc[i] = Math.max(inc[i], inc[j] + 1);
                }
            }
        }

        for (int i = n - 1; i >= 0; i--) {
            dec[i] = 1;
            for (int j = n - 1; j > i; j--) {
                if (nums[i] > nums[j]) {
                    dec[i] = Math.max(dec[i], dec[j] + 1);
                }
            }
        }

        int maxLen = 0;
        for (int i = 0; i < n; i++) {
            if (inc[i] > 1 && dec[i] > 1) {
                maxLen = Math.max(maxLen, inc[i] + dec[i] - 1);
            }
        }

        return n - maxLen;
    }
}