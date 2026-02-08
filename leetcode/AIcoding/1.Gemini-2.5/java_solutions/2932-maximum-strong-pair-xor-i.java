class Solution {
    public int maximumStrongPairXor(int[] nums) {
        int max_xor = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int x = nums[i];
                int y = nums[j];

                // Check if (x, y) is a strong pair
                // The condition |x - y| <= min(x, y) is equivalent to max(x, y) <= 2 * min(x, y)
                int minVal = Math.min(x, y);
                int maxVal = Math.max(x, y);

                if (maxVal <= 2 * minVal) {
                    max_xor = Math.max(max_xor, x ^ y);
                }
            }
        }

        return max_xor;
    }
}