class Solution {
    public int[] sumOfAbsoluteDifferences(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        long[] prefixSum = new long[n + 1];

        // Calculate prefix sums
        // prefixSum[k] stores the sum of nums[0]...nums[k-1]
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int i = 0; i < n; i++) {
            // For elements to the left of nums[i]: nums[0]...nums[i-1]
            // There are 'i' elements.
            // Sum of (nums[i] - nums[j]) for j < i
            // = nums[i] * i - (sum of nums[0]...nums[i-1])
            long leftCount = i;
            long leftSum = prefixSum[i]; // sum of nums[0]...nums[i-1]
            long diffLeft = (long)nums[i] * leftCount - leftSum;

            // For elements to the right of nums[i]: nums[i+1]...nums[n-1]
            // There are (n - 1 - i) elements.
            // Sum of (nums[j] - nums[i]) for j > i
            // = (sum of nums[i+1]...nums[n-1]) - nums[i] * (n - 1 - i)
            long rightCount = n - 1 - i;
            long rightSum = prefixSum[n] - prefixSum[i + 1]; // sum of nums[i+1]...nums[n-1]
            long diffRight = rightSum - (long)nums[i] * rightCount;

            result[i] = (int)(diffLeft + diffRight);
        }

        return result;
    }
}