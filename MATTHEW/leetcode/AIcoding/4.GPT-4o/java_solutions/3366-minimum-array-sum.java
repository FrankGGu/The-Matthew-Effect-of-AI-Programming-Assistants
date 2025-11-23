class Solution {
    public int minArraySum(int[] nums) {
        int minSum = 0;
        for (int num : nums) {
            minSum += num;
        }
        return minSum;
    }
}