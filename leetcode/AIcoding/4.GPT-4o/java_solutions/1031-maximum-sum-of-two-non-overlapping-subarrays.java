class Solution {
    public int maxSumTwoNoOverlap(int[] nums, int firstLen, int secondLen) {
        return Math.max(maxSum(nums, firstLen, secondLen), maxSum(nums, secondLen, firstLen));
    }

    private int maxSum(int[] nums, int firstLen, int secondLen) {
        int n = nums.length;
        int maxFirst = 0, maxSecond = 0, sumFirst = 0, sumSecond = 0;

        for (int i = 0; i < n; i++) {
            if (i < firstLen) {
                sumFirst += nums[i];
            } else if (i < firstLen + secondLen) {
                sumSecond += nums[i];
                maxFirst = Math.max(maxFirst, sumFirst);
                sumFirst += nums[i - secondLen];
            } else {
                sumSecond += nums[i];
                maxFirst = Math.max(maxFirst, sumFirst);
                sumFirst += nums[i - secondLen];
                maxSecond = Math.max(maxSecond, sumSecond);
            }
        }

        return Math.max(maxFirst + maxSecond, maxFirst);
    }
}