class Solution {
    public int minStartValue(int[] nums) {
        int minPrefixSum = 0;
        int prefixSum = 0;
        for (int num : nums) {
            prefixSum += num;
            minPrefixSum = Math.min(minPrefixSum, prefixSum);
        }
        return 1 - minPrefixSum;
    }
}