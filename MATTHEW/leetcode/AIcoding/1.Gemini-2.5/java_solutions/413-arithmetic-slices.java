class Solution {
    public int numberOfArithmeticSlices(int[] nums) {
        int totalSlices = 0;
        int currentConsecutiveSlices = 0;

        if (nums.length < 3) {
            return 0;
        }

        for (int i = 2; i < nums.length; i++) {
            if (nums[i] - nums[i-1] == nums[i-1] - nums[i-2]) {
                currentConsecutiveSlices++;
                totalSlices += currentConsecutiveSlices;
            } else {
                currentConsecutiveSlices = 0;
            }
        }

        return totalSlices;
    }
}