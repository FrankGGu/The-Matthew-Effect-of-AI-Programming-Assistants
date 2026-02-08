class Solution {
    public int maxSumTwoNoOverlap(int[] nums, int firstLen, int secondLen) {
        return Math.max(maxSum(nums, firstLen, secondLen), maxSum(nums, secondLen, firstLen));
    }

    private int maxSum(int[] nums, int firstLen, int secondLen) {
        int n = nums.length;
        int[] sum = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            sum[i] = sum[i - 1] + nums[i - 1];
        }

        int maxFirst = 0;
        int result = 0;
        for (int i = firstLen + secondLen; i <= n; i++) {
            maxFirst = Math.max(maxFirst, sum[i - secondLen] - sum[i - secondLen - firstLen]);
            result = Math.max(result, maxFirst + sum[i] - sum[i - secondLen]);
        }

        return result;
    }
}