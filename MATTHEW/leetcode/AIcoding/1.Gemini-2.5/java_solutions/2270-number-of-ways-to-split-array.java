class Solution {
    public int waysToSplitArray(int[] nums) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int count = 0;
        long currentLeftSum = 0;

        // Iterate through all possible split points 'i'
        // 'i' ranges from 0 to n-2, as the right part must contain at least one element.
        for (int i = 0; i < nums.length - 1; i++) {
            currentLeftSum += nums[i];
            long currentRightSum = totalSum - currentLeftSum;

            if (currentLeftSum >= currentRightSum) {
                count++;
            }
        }

        return count;
    }
}