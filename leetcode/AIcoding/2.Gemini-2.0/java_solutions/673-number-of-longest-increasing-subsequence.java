class Solution {
    public int findNumberOfLIS(int[] nums) {
        int n = nums.length;
        if (n <= 1) {
            return n;
        }
        int[] lengths = new int[n];
        int[] counts = new int[n];
        for (int i = 0; i < n; i++) {
            lengths[i] = 1;
            counts[i] = 1;
        }
        for (int j = 1; j < n; j++) {
            for (int i = 0; i < j; i++) {
                if (nums[i] < nums[j]) {
                    if (lengths[i] + 1 > lengths[j]) {
                        lengths[j] = lengths[i] + 1;
                        counts[j] = counts[i];
                    } else if (lengths[i] + 1 == lengths[j]) {
                        counts[j] += counts[i];
                    }
                }
            }
        }
        int maxLength = 0;
        for (int length : lengths) {
            maxLength = Math.max(maxLength, length);
        }
        int result = 0;
        for (int i = 0; i < n; i++) {
            if (lengths[i] == maxLength) {
                result += counts[i];
            }
        }
        return result;
    }
}