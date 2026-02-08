class Solution {
    public int minStartValue(int[] nums) {
        int currentSum = 0;
        int minPrefixSum = 0;

        for (int num : nums) {
            currentSum += num;
            minPrefixSum = Math.min(minPrefixSum, currentSum);
        }

        return 1 - minPrefixSum;
    }
}