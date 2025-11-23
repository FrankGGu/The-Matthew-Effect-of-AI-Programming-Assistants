class Solution {
    public int minSwaps(int[] nums) {
        int n = nums.length;
        int ones = 0;
        for (int num : nums) {
            if (num == 1) {
                ones++;
            }
        }
        int windowOnes = 0;
        for (int i = 0; i < ones; i++) {
            if (nums[i] == 1) {
                windowOnes++;
            }
        }
        int maxOnes = windowOnes;
        for (int i = ones; i < n; i++) {
            if (nums[i] == 1) {
                windowOnes++;
            }
            if (nums[i - ones] == 1) {
                windowOnes--;
            }
            maxOnes = Math.max(maxOnes, windowOnes);
        }
        return ones - maxOnes;
    }
}