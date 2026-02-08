import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public long minGroupsForCount(long c, int x) {
        // If count is less than x, it's impossible to form groups of size x or x+1.
        // Return a sentinel value indicating impossibility.
        if (c < x) {
            return Long.MAX_VALUE;
        }

        long minK = Long.MAX_VALUE;
        // S_denom represents (2x+1) from the derivations.
        // It's used as a common divisor in the three cases.
        long S_denom = 2L * x + 1;

        // Case 1: Total groups k is even.
        // Let k = 2m. Then num_x = m and num_x_plus_1 = m.
        // Total items: c = m * x + m * (x+1) = m * (2x+1)
        if (c % S_denom == 0) {
            long m = c / S_denom;
            long k_candidate = 2 * m;
            // Since c >= 1 and S_denom >= 3 (as x >= 1), m will be >= 0.
            // If m=0, c must be 0, which is not possible for a frequency. So m >= 1.
            // Thus k_candidate will be >= 2.
            minK = Math.min(minK, k_candidate);
        }

        // Case 2: Total groups k is odd.
        // Let k = 2m+1. Then num_x = m+1 and num_x_plus_1 = m.
        // Total items: c = (m+1) * x + m * (x+1) = m * (2x+1) + x
        // So (c - x) must be a multiple of (2x+1).
        if (c >= x && (c - x) % S_denom == 0) {
            long m = (c - x) / S_denom;
            long k_candidate = 2 * m + 1;
            // Since c >= x, (c-x) >= 0, so m >= 0.
            // If m=0, k_candidate=1, which is a valid number of groups.
            minK = Math.min(minK, k_candidate);
        }

        // Case 3: Total groups k is odd.
        // Let k = 2m+1. Then num_x = m and num_x_plus_1 = m+1.
        // Total items: c = m * x + (m+1) * (x+1) = m * (2x+1) + x + 1
        // So (c - (x+1)) must be a multiple of (2x+1).
        if (c >= x + 1 && (c - (x + 1)) % S_denom == 0) {
            long m = (c - (x + 1)) / S_denom;
            long k_candidate = 2 * m + 1;
            // Since c >= x+1, (c-(x+1)) >= 0, so m >= 0.
            // If m=0, k_candidate=1, which is a valid number of groups.
            minK = Math.min(minK, k_candidate);
        }

        return minK;
    }

    public int minimumNumberGroups(int[] nums) {
        // Step 1: Count frequencies of each item type.
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        // Step 2: Extract distinct frequencies into a list.
        // The number of distinct frequencies is at most O(sqrt(N)), where N is nums.length.
        List<Integer> distinctCounts = new ArrayList<>(freqMap.values());

        // Step 3: Find the maximum frequency (max_val).
        // This determines the upper bound for the search space of 'x'.
        // If x > max_val, then for any item type with count 'c', c < x, making it impossible
        // to form groups of size 'x' or 'x+1'.
        int max_val = 0;
        for (int count : distinctCounts) {
            if (count > max_val) {
                max_val = count;
            }
        }

        long overallMinGroups = Long.MAX_VALUE;

        // Step 4: Iterate through possible values of 'x'.
        // 'x' must be at least 1, as group size must be positive.
        // The loop runs max_val times.
        for (int x = 1; x <= max_val; x++) {
            long currentTotalGroups = 0;
            boolean possible = true;

            // For each distinct frequency 'c', calculate the minimum groups needed.
            // This inner loop runs distinctCounts.size() times, which is O(sqrt(N)).
            for (int c : distinctCounts) {
                long groupsForThisCount = minGroupsForCount(c, x);
                if (groupsForThisCount == Long.MAX_VALUE) {
                    possible = false; // This 'x' is not valid for all item types.
                    break;
                }
                currentTotalGroups += groupsForThisCount;
            }

            // If 'x' is valid for all item types, update the overall minimum.
            if (possible) {
                overallMinGroups = Math.min(overallMinGroups, currentTotalGroups);
            }
        }

        return (int) overallMinGroups;
    }
}