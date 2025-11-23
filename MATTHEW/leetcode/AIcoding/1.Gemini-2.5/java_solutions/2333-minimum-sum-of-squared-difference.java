class Solution {
    public long minSumSquareDiff(int[] nums1, int[] nums2, int k1, int k2) {
        int n = nums1.length;
        // Max possible difference is 10^5 (10^5 - 0)
        // We need an array to store counts of each difference value.
        // Index represents the difference, value represents its frequency.
        int[] diffCounts = new int[100001]; 
        int maxDiff = 0;

        // Calculate initial absolute differences and populate diffCounts
        for (int i = 0; i < n; i++) {
            int diff = Math.abs(nums1[i] - nums2[i]);
            diffCounts[diff]++;
            if (diff > maxDiff) {
                maxDiff = diff;
            }
        }

        // Total operations available
        long k = (long) k1 + k2;

        // Iterate from the largest difference down to 1
        // It's always optimal to reduce larger differences first.
        for (int d = maxDiff; d > 0; d--) {
            if (k == 0) {
                break; // No operations left
            }
            if (diffCounts[d] == 0) {
                continue; // No elements with this difference
            }

            // Number of elements currently having difference 'd'
            int count = diffCounts[d];

            // If we have enough operations to reduce all 'count' elements from 'd' to 'd-1'
            if (k >= count) {
                k -= count; // Use 'count' operations
                diffCounts[d - 1] += count; // These 'count' elements now have difference 'd-1'
                // diffCounts[d] implicitly becomes 0 for future calculations as we iterate downwards
            } else {
                // We don't have enough operations to reduce all 'count' elements.
                // We can only reduce 'k' elements from 'd' to 'd-1'.
                diffCounts[d - 1] += k; // 'k' elements now have difference 'd-1'
                diffCounts[d] -= k;     // The remaining (count - k) elements stay at 'd'
                k = 0;                  // All operations exhausted
                break;
            }
        }

        // Calculate the sum of squares of the remaining differences
        long totalSquaredDiff = 0;
        for (int d = 0; d <= maxDiff; d++) {
            if (diffCounts[d] > 0) {
                totalSquaredDiff += (long) diffCounts[d] * d * d;
            }
        }

        return totalSquaredDiff;
    }
}