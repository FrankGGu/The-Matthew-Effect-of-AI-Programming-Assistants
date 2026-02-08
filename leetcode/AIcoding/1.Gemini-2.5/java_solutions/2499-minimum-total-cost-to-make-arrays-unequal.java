import java.util.*;

class Solution {
    public long minimumTotalCost(int[] nums1, int[] nums2) {
        long totalCost = 0;
        Map<Integer, Integer> badCounts = new HashMap<>();
        int maxFreq = 0;
        int maxFreqVal = -1; // Value that appears most frequently at problematic indices

        List<Integer> candidates = new ArrayList<>(); // Values that can be swapped with maxFreqVal

        int n = nums1.length;
        for (int i = 0; i < n; ++i) {
            if (nums1[i] == nums2[i]) {
                totalCost += nums1[i]; // Accumulate initial cost of problematic values
                badCounts.put(nums1[i], badCounts.getOrDefault(nums1[i], 0) + 1);

                // Track the most frequent problematic value
                if (badCounts.get(nums1[i]) > maxFreq) {
                    maxFreq = badCounts.get(nums1[i]);
                    maxFreqVal = nums1[i];
                } else if (badCounts.get(nums1[i]) == maxFreq) {
                    // If frequencies are tied, pick the smaller value for maxFreqVal
                    // This maximizes potential savings (maxFreqVal - y)
                    maxFreqVal = Math.min(maxFreqVal, nums1[i]);
                }
            } else {
                candidates.add(nums1[i]); // Non-problematic values are candidates for swaps
            }
        }

        if (badCounts.isEmpty()) {
            return 0; // No problematic pairs, cost is 0
        }

        // Add other problematic values (that are not maxFreqVal) to candidates
        // These can be swapped with maxFreqVal to fix its occurrences
        for (Map.Entry<Integer, Integer> entry : badCounts.entrySet()) {
            if (entry.getKey() != maxFreqVal) {
                for (int i = 0; i < entry.getValue(); ++i) {
                    candidates.add(entry.getKey());
                }
            }
        }

        Collections.sort(candidates); // Sort candidates to pick smallest values first

        // Iterate through candidates to find values to swap with maxFreqVal
        // Each swap with y < maxFreqVal reduces the totalCost by (maxFreqVal - y)
        for (int y : candidates) {
            if (maxFreq == 0) {
                break; // All occurrences of maxFreqVal have been accounted for
            }

            if (y < maxFreqVal) {
                totalCost -= (maxFreqVal - y); // Reduce cost
                maxFreq--; // One occurrence of maxFreqVal is 'fixed'
            } else {
                // If y >= maxFreqVal, swapping maxFreqVal with y costs min(maxFreqVal, y) = maxFreqVal.
                // The original cost contribution for this maxFreqVal was maxFreqVal. So, no net saving (maxFreqVal - maxFreqVal = 0).
                // Further values in candidates will also be >= maxFreqVal, so no further savings are possible.
                break;
            }
        }

        return totalCost;
    }
}