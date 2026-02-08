class Solution {
    public int minOperations(int[] nums) {
        int operations = 0;
        int flipCount = 0;

        for (int i = 0; i < nums.length; i++) {
            int currentEffectiveValue = (nums[i] + flipCount) % 2;

            if (currentEffectiveValue == 0) {
                operations++;
                flipCount++;
            }
        }

        return operations;
    }
}