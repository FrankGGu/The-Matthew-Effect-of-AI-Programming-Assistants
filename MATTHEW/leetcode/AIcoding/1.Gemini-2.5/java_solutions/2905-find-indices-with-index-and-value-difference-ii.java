class Solution {
    public int[] findIndices(int[] nums, int indexDifference, int valueDifference) {
        int n = nums.length;

        // minIdx stores the index of the minimum value encountered so far
        // within the range of indices [0, j - indexDifference]
        int minIdx = 0;
        // maxIdx stores the index of the maximum value encountered so far
        // within the range of indices [0, j - indexDifference]
        int maxIdx = 0;

        // Iterate j from indexDifference to n-1.
        // This ensures that for any j, j - indexDifference is a valid non-negative index,
        // allowing us to consider indices 'i' that satisfy abs(i - j) >= indexDifference.
        for (int j = indexDifference; j < n; j++) {
            // k is the current "earliest" index that satisfies the indexDifference condition with j.
            // We use nums[k] to update our running min/max values for indices i <= j - indexDifference.
            int k = j - indexDifference;

            // Update minIdx if nums[k] is smaller than the value at current minIdx
            if (nums[k] < nums[minIdx]) {
                minIdx = k;
            }
            // Update maxIdx if nums[k] is larger than the value at current maxIdx
            if (nums[k] > nums[maxIdx]) {
                maxIdx = k;
            }

            // Now, check if the current nums[j] forms a valid pair with either
            // the minimum value (nums[minIdx]) or the maximum value (nums[maxIdx])
            // found so far in the valid range [0, j - indexDifference].
            if (Math.abs(nums[j] - nums[minIdx]) >= valueDifference) {
                return new int[]{minIdx, j};
            }
            if (Math.abs(nums[j] - nums[maxIdx]) >= valueDifference) {
                return new int[]{maxIdx, j};
            }
        }

        // If no such pair is found after checking all possible j
        return new int[]{-1, -1};
    }
}