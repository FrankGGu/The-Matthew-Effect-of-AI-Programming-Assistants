class Solution {
    public int maxDifferenceEvenOddFrequency(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0; 
        }

        int n = nums.length;
        int[] transformedNums = new int[n];
        for (int i = 0; i < n; i++) {
            if (nums[i] % 2 == 0) {
                transformedNums[i] = 1; // Even numbers contribute +1 to the difference (even_count - odd_count)
            } else {
                transformedNums[i] = -1; // Odd numbers contribute -1 to the difference
            }
        }

        // Calculate the maximum possible value of (even_count - odd_count) for any subarray
        // This is equivalent to finding the maximum subarray sum in transformedNums.
        int maxEvenMinusOdd = transformedNums[0];
        int currentMaxSum = transformedNums[0];
        for (int i = 1; i < n; i++) {
            currentMaxSum = Math.max(transformedNums[i], currentMaxSum + transformedNums[i]);
            maxEvenMinusOdd = Math.max(maxEvenMinusOdd, currentMaxSum);
        }

        // Calculate the minimum possible value of (even_count - odd_count) for any subarray
        // This is equivalent to finding the minimum subarray sum in transformedNums.
        int minEvenMinusOdd = transformedNums[0];
        int currentMinSum = transformedNums[0];
        for (int i = 1; i < n; i++) {
            currentMinSum = Math.min(transformedNums[i], currentMinSum + transformedNums[i]);
            minEvenMinusOdd = Math.min(minEvenMinusOdd, currentMinSum);
        }

        // The maximum absolute difference is the maximum of the absolute values of these two extremes.
        // For example, if maxEvenMinusOdd is 5 and minEvenMinusOdd is -3, the maximum absolute difference is max(|5|, |-3|) = 5.
        // If maxEvenMinusOdd is 3 and minEvenMinusOdd is -5, the maximum absolute difference is max(|3|, |-5|) = 5.
        return Math.max(Math.abs(maxEvenMinusOdd), Math.abs(minEvenMinusOdd));
    }
}