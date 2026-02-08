import java.util.Map;
import java.util.TreeMap;

class Solution {
    public int oddEvenJumps(int[] arr) {
        int n = arr.length;
        if (n <= 1) {
            return n;
        }

        // dp[i][0] indicates if we can reach the end starting from index i with an odd jump (1st, 3rd, ...)
        // dp[i][1] indicates if we can reach the end starting from index i with an even jump (2nd, 4th, ...)
        boolean[][] dp = new boolean[n][2];

        // Base case: From the last index, we are already at the end, so both types of jumps are considered successful.
        dp[n - 1][0] = true;
        dp[n - 1][1] = true;

        // Initialize count of good starting indices. The last index is always good.
        int goodStartingIndices = 1;

        // TreeMap to store (value -> index) for elements encountered so far (from right to left).
        // This allows efficient lookup for ceiling (next greater/equal) and floor (next smaller/equal) values.
        // When duplicate values are inserted, TreeMap.put() updates the index. Since we iterate from right to left,
        // the stored index for a given value will always be the smallest index encountered so far for that value.
        TreeMap<Integer, Integer> map = new TreeMap<>();
        map.put(arr[n - 1], n - 1);

        // Iterate from the second-to-last element down to the first.
        for (int i = n - 2; i >= 0; i--) {
            // --- Determine next jump for an ODD jump from index i ---
            // An odd jump requires finding the smallest arr[j] >= arr[i] among j > i.
            // If multiple such j's exist, pick the smallest index j.
            // map.ceilingEntry(arr[i]) finds the entry with the smallest key (value) that is greater than or equal to arr[i].
            // The value associated with this key (entry.getValue()) will be the smallest index j due to TreeMap's update behavior.
            Integer nextGreaterOrEqualIdx = null;
            Map.Entry<Integer, Integer> ceilingEntry = map.ceilingEntry(arr[i]);
            if (ceilingEntry != null) {
                nextGreaterOrEqualIdx = ceilingEntry.getValue();
            }

            // If an odd jump is possible from i to nextGreaterOrEqualIdx,
            // then the next jump from nextGreaterOrEqualIdx must be an even jump.
            if (nextGreaterOrEqualIdx != null) {
                dp[i][0] = dp[nextGreaterOrEqualIdx][1];
            } else {
                dp[i][0] = false; // No valid odd jump from i
            }

            // --- Determine next jump for an EVEN jump from index i ---
            // An even jump requires finding the largest arr[j] <= arr[i] among j > i.
            // If multiple such j's exist, pick the smallest index j.
            // map.floorEntry(arr[i]) finds the entry with the largest key (value) that is less than or equal to arr[i].
            // The value associated with this key (entry.getValue()) will be the smallest index j due to TreeMap's update behavior.
            Integer nextSmallerOrEqualIdx = null;
            Map.Entry<Integer, Integer> floorEntry = map.floorEntry(arr[i]);
            if (floorEntry != null) {
                nextSmallerOrEqualIdx = floorEntry.getValue();
            }

            // If an even jump is possible from i to nextSmallerOrEqualIdx,
            // then the next jump from nextSmallerOrEqualIdx must be an odd jump.
            if (nextSmallerOrEqualIdx != null) {
                dp[i][1] = dp[nextSmallerOrEqualIdx][0];
            } else {
                dp[i][1] = false; // No valid even jump from i
            }

            // If we can make an odd jump from index i and eventually reach the end,
            // then i is a good starting index.
            if (dp[i][0]) {
                goodStartingIndices++;
            }

            // Add the current element's value and index to the TreeMap for future iterations.
            map.put(arr[i], i);
        }

        return goodStartingIndices;
    }
}