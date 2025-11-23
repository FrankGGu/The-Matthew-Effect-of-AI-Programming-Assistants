class Solution {
    public int minPositiveSum(int[] nums) {
        int minSum = Integer.MAX_VALUE;
        int currentSum = 0;
        boolean hasPositive = false;

        for (int num : nums) {
            if (num > 0) {
                hasPositive = true;
                currentSum += num;
            } else {
                if (currentSum > 0) {
                    minSum = Math.min(minSum, currentSum);
                }
                currentSum = 0;
            }
        }

        if (currentSum > 0) {
            minSum = Math.min(minSum, currentSum);
        }

        return hasPositive ? minSum : 0;
    }
}