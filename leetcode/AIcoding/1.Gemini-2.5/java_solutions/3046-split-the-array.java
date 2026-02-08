class Solution {
    public int waysToSplitArray(int[] nums) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int count = 0;
        long currentLeftSum = 0;
        int n = nums.length;

        // Iterate through all possible split points k
        // k ranges from 0 to n-2 (inclusive)
        // A split point k means the first part includes nums[0]...nums[k]
        // and the second part includes nums[k+1]...nums[n-1]
        for (int k = 0; k < n - 1; k++) {
            currentLeftSum += nums[k];

            long leftCount = k + 1;
            long rightSum = totalSum - currentLeftSum;
            long rightCount = n - (k + 1);

            // Check if the averages are equal using cross-multiplication to avoid floating point issues
            // leftSum / leftCount == rightSum / rightCount
            // is equivalent to leftSum * rightCount == rightSum * leftCount
            if (currentLeftSum * rightCount == rightSum * leftCount) {
                count++;
            }
        }

        return count;
    }
}