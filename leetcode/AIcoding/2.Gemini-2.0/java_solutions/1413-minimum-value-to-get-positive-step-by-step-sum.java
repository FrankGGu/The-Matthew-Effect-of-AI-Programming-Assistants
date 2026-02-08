class Solution {
    public int minStartValue(int[] nums) {
        int minSum = Integer.MAX_VALUE;
        int currentSum = 0;
        for (int num : nums) {
            currentSum += num;
            minSum = Math.min(minSum, currentSum);
        }
        if (minSum > 0) {
            return 1;
        } else {
            return 1 - minSum;
        }
    }
}