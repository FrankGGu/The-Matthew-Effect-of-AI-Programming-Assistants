import java.util.Arrays;

class Solution {
    public long[] minOperations(int[] nums, int[] queries) {
        Arrays.sort(nums);
        int n = nums.length;
        long[] prefixSums = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSums[i + 1] = prefixSums[i] + nums[i];
        }

        int m = queries.length;
        long[] ans = new long[m];

        for (int i = 0; i < m; i++) {
            int target = queries[i];

            // Find the count of elements in nums that are less than or equal to target.
            // This 'idx' will represent the split point:
            // nums[0...idx-1] are <= target
            // nums[idx...n-1] are > target
            int idx = Arrays.binarySearch(nums, target);
            if (idx < 0) {
                // target is not found. idx is - (insertion_point) - 1.
                // insertion_point is the index of the first element greater than target.
                // So, -idx - 1 gives the count of elements less than target.
                idx = -idx - 1;
            } else {
                // target is found at 'idx'. We need to find the count of all elements
                // that are less than or equal to target, which means advancing 'idx'
                // past all occurrences of 'target'.
                while (idx < n && nums[idx] == target) {
                    idx++;
                }
            }

            // Operations for elements <= target: sum(target - nums[j])
            // This is (count of elements <= target) * target - sum(elements <= target)
            long sumLeft = (long)idx * target - prefixSums[idx];

            // Operations for elements > target: sum(nums[j] - target)
            // This is sum(elements > target) - (count of elements > target) * target
            long sumRight = (prefixSums[n] - prefixSums[idx]) - (long)(n - idx) * target;

            ans[i] = sumLeft + sumRight;
        }

        return ans;
    }
}