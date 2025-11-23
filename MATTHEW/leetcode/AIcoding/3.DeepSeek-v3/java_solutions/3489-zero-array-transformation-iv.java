class Solution {
    public int minOperations(int[] nums) {
        int operations = 0;
        while (true) {
            boolean allZero = true;
            int minNonZero = Integer.MAX_VALUE;
            for (int num : nums) {
                if (num != 0) {
                    allZero = false;
                    if (num < minNonZero) {
                        minNonZero = num;
                    }
                }
            }
            if (allZero) {
                break;
            }
            for (int i = 0; i < nums.length; i++) {
                if (nums[i] != 0) {
                    nums[i] -= minNonZero;
                    operations++;
                }
            }
        }
        return operations;
    }
}