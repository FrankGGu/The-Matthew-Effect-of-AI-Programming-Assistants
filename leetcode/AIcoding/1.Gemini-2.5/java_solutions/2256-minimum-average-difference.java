class Solution {
    public int minimumAverageDifference(int[] nums) {
        int n = nums.length;
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        long minAvgDiff = Long.MAX_VALUE;
        int resultIndex = -1;
        long currentLeftSum = 0;

        for (int i = 0; i < n; i++) {
            currentLeftSum += nums[i];

            long leftCount = i + 1;
            long leftAvg = currentLeftSum / leftCount;

            long rightCount = n - leftCount;
            long rightAvg = 0;

            if (rightCount > 0) {
                long currentRightSum = totalSum - currentLeftSum;
                rightAvg = currentRightSum / rightCount;
            }

            long currentAvgDiff = Math.abs(leftAvg - rightAvg);

            if (currentAvgDiff < minAvgDiff) {
                minAvgDiff = currentAvgDiff;
                resultIndex = i;
            }
        }

        return resultIndex;
    }
}