class Solution {
    public int minStartValue(int[] nums) {
        int minSum = 0, currentSum = 0;
        for (int num : nums) {
            currentSum += num;
            minSum = Math.min(minSum, currentSum);
        }
        return 1 - minSum;
    }
}