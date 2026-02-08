class Solution {
    public int maxSubarraySumCircular(int[] nums) {
        int totalSum = 0;
        int maxSoFar = Integer.MIN_VALUE;
        int currentMax = 0;
        int minSoFar = Integer.MAX_VALUE;
        int currentMin = 0;

        for (int num : nums) {
            totalSum += num;

            currentMax = Math.max(num, currentMax + num);
            maxSoFar = Math.max(maxSoFar, currentMax);

            currentMin = Math.min(num, currentMin + num);
            minSoFar = Math.min(minSoFar, currentMin);
        }

        if (maxSoFar < 0) {
            return maxSoFar;
        }

        return Math.max(maxSoFar, totalSum - minSoFar);
    }
}