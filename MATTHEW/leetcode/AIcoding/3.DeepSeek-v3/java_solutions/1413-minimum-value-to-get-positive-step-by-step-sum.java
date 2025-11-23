class Solution {
    public int minStartValue(int[] nums) {
        int minSum = 0;
        int currentSum = 0;
        for (int num : nums) {
            currentSum += num;
            if (currentSum < minSum) {
                minSum = currentSum;
            }
        }
        return 1 - minSum;
    }
}