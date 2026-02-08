public class Solution {
    public int minimizeXOR(int[] nums, int x) {
        int n = nums.length;
        int min = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int xor = nums[i] ^ x;
            if (xor < min) {
                min = xor;
            }
        }
        return min;
    }
}