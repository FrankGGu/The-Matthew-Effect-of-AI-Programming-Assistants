class Solution {
    public int maximizeSum(int[] nums, int k) {
        int maxVal = 0;
        for (int num : nums) {
            if (num > maxVal) {
                maxVal = num;
            }
        }

        // The numbers picked will be maxVal, maxVal + 1, ..., maxVal + (k - 1).
        // This is an arithmetic progression.
        // The sum can be calculated as:
        // k * maxVal + (0 + 1 + ... + k - 1)
        // The sum of the first (k-1) non-negative integers is k * (k - 1) / 2.
        // So, the total sum is k * maxVal + k * (k - 1) / 2.

        int sum = k * maxVal + k * (k - 1) / 2;

        return sum;
    }
}