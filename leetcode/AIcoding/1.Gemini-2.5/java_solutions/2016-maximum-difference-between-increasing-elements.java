class Solution {
    public int maximumDifference(int[] nums) {
        int maxDiff = -1;
        int minElement = Integer.MAX_VALUE;

        for (int num : nums) {
            if (num > minElement) {
                maxDiff = Math.max(maxDiff, num - minElement);
            }
            minElement = Math.min(minElement, num);
        }

        return maxDiff;
    }
}