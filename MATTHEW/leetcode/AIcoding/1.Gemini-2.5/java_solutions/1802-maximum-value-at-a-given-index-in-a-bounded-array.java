class Solution {
    public int maxValue(int n, int index, int maxSum) {
        int low = 1;
        int high = maxSum; // The maximum possible value at any index is maxSum itself
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, n, index, maxSum)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    // Helper function to calculate the sum of elements on one side (left or right)
    // starting from 'peakValue' and decreasing by 1, with a minimum of 1.
    // length: the number of elements on this side.
    private long calculateSideSum(long peakValue, int length) {
        if (length == 0) {
            return 0;
        }

        // If the peakValue is large enough to cover all 'length' elements while decreasing to 1,
        // the sequence is peakValue, peakValue-1, ..., peakValue-length+1.
        // All elements in this sequence are guaranteed to be >= 1.
        if (peakValue >= length) {
            // This is an arithmetic series sum: n * (first + last) / 2
            // Here, n = length, first = peakValue, last = peakValue - length + 1
            return length * (2 * peakValue - length + 1) / 2;
        } else {
            // If peakValue is less than length, the sequence will decrease to 1,
            // and then the remaining (length - peakValue) elements will also be 1s.
            // Sum of 1 to peakValue: peakValue * (peakValue + 1) / 2
            // Sum of remaining (length - peakValue) ones: (length - peakValue) * 1
            return peakValue * (peakValue + 1) / 2 + (length - peakValue);
        }
    }

    // Check if it's possible to have 'mid' as the value at 'index'
    // such that the total sum of the array does not exceed 'maxSum'.
    private boolean check(int mid, int n, int index, int maxSum) {
        long currentSum = mid; // Value at nums[index]

        // Calculate sum for the left side of 'index'
        // There are 'index' elements on the left.
        // The element adjacent to nums[index] would be mid - 1.
        currentSum += calculateSideSum(mid - 1, index);

        // Calculate sum for the right side of 'index'
        // There are (n - 1 - index) elements on the right.
        // The element adjacent to nums[index] would also be mid - 1.
        currentSum += calculateSideSum(mid - 1, n - 1 - index);

        return currentSum <= maxSum;
    }
}