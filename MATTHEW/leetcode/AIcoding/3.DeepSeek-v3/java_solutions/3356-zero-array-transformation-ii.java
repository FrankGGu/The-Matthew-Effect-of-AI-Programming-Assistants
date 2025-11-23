class Solution {
    public int minOperations(int[] nums) {
        int operations = 0;
        while (true) {
            int minNonZero = Integer.MAX_VALUE;
            int countNonZero = 0;
            for (int num : nums) {
                if (num > 0) {
                    countNonZero++;
                    if (num < minNonZero) {
                        minNonZero = num;
                    }
                }
            }
            if (countNonZero == 0) {
                break;
            }
            operations += minNonZero;
            for (int i = 0; i < nums.length; i++) {
                if (nums[i] > 0) {
                    nums[i] -= minNonZero;
                }
            }
        }
        return operations;
    }
}