class Solution {
    public long maxAlternatingSum(int[] nums) {
        long evenSum = 0, oddSum = 0;
        for (int num : nums) {
            evenSum = Math.max(evenSum, oddSum + num);
            oddSum = evenSum - num;
        }
        return evenSum;
    }
}