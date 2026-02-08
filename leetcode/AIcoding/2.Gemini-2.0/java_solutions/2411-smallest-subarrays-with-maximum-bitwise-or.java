class Solution {
    public int[] smallestSubarrays(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int[] last = new int[32];
        for (int i = n - 1; i >= 0; i--) {
            for (int j = 0; j < 32; j++) {
                if ((nums[i] & (1 << j)) != 0) {
                    last[j] = i;
                }
            }
            int right = i;
            for (int j = 0; j < 32; j++) {
                right = Math.max(right, last[j]);
            }
            result[i] = right - i + 1;
        }
        return result;
    }
}