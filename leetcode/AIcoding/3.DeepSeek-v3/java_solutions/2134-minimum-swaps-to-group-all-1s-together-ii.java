class Solution {
    public int minSwaps(int[] nums) {
        int ones = 0;
        for (int num : nums) {
            if (num == 1) {
                ones++;
            }
        }

        if (ones == 0 || ones == nums.length) {
            return 0;
        }

        int[] circular = new int[nums.length * 2];
        for (int i = 0; i < circular.length; i++) {
            circular[i] = nums[i % nums.length];
        }

        int maxOnesInWindow = 0;
        int currentOnes = 0;

        for (int i = 0; i < circular.length; i++) {
            if (i >= ones && circular[i - ones] == 1) {
                currentOnes--;
            }
            if (circular[i] == 1) {
                currentOnes++;
            }
            if (currentOnes > maxOnesInWindow) {
                maxOnesInWindow = currentOnes;
            }
        }

        return ones - maxOnesInWindow;
    }
}