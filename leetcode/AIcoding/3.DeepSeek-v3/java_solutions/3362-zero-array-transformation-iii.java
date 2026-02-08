class Solution {
    public int minimumOperations(int[] nums) {
        int operations = 0;
        while (true) {
            int min = Integer.MAX_VALUE;
            boolean allZero = true;
            for (int num : nums) {
                if (num != 0) {
                    allZero = false;
                    if (num < min) {
                        min = num;
                    }
                }
            }
            if (allZero) {
                break;
            }
            for (int i = 0; i < nums.length; i++) {
                if (nums[i] != 0) {
                    nums[i] -= min;
                }
            }
            operations++;
        }
        return operations;
    }
}