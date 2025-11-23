class Solution {
    public int maxAbsoluteSum(int[] nums) {
        int maxSoFar = 0;
        int minSoFar = 0;
        int currentMax = 0;
        int currentMin = 0;

        for (int num : nums) {
            currentMax = Math.max(num, currentMax + num);
            maxSoFar = Math.max(maxSoFar, currentMax);

            currentMin = Math.min(num, currentMin + num);
            minSoFar = Math.min(minSoFar, currentMin);
        }

        return Math.max(Math.abs(maxSoFar), Math.abs(minSoFar));
    }
}