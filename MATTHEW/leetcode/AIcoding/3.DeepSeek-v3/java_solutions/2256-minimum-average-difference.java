class Solution {
    public int minimumAverageDifference(int[] nums) {
        int n = nums.length;
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        long minDiff = Long.MAX_VALUE;
        int minIndex = 0;
        long leftSum = 0;

        for (int i = 0; i < n; i++) {
            leftSum += nums[i];
            long leftAvg = leftSum / (i + 1);
            long rightSum = totalSum - leftSum;
            long rightAvg = (i == n - 1) ? 0 : rightSum / (n - i - 1);
            long diff = Math.abs(leftAvg - rightAvg);

            if (diff < minDiff) {
                minDiff = diff;
                minIndex = i;
            }
        }

        return minIndex;
    }
}