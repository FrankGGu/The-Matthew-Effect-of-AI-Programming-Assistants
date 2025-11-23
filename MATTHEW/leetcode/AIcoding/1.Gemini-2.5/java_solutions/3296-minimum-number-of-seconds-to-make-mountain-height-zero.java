import java.util.*;

class Solution {
    public int minimumSeconds(List<Integer> nums) {
        int n = nums.size();
        Map<Integer, List<Integer>> valIndices = new HashMap<>();

        for (int i = 0; i < n; i++) {
            valIndices.computeIfAbsent(nums.get(i), k -> new ArrayList<>()).add(i);
        }

        int minSeconds = Integer.MAX_VALUE;

        for (Map.Entry<Integer, List<Integer>> entry : valIndices.entrySet()) {
            int val = entry.getKey();
            List<Integer> indices = entry.getValue();

            int maxInterval = 0;

            // Calculate maximum interval between adjacent occurrences
            // considering linear segments
            for (int i = 0; i < indices.size() - 1; i++) {
                maxInterval = Math.max(maxInterval, indices.get(i + 1) - indices.get(i));
            }

            // Consider the circular segment (between last and first occurrence)
            // This is only relevant if there's more than one occurrence.
            // If there's only one occurrence, the "interval" is effectively the entire array length 'n'.
            if (indices.size() > 1) {
                maxInterval = Math.max(maxInterval, n - indices.get(indices.size() - 1) + indices.get(0));
            } else {
                // If there's only one occurrence of 'val', the effective interval is 'n'.
                // This means 'val' is separated from itself by 'n' positions in a circular array.
                maxInterval = n;
            }

            // The time required for this 'val' to clear its widest gap
            // is 'val' (to reduce itself to zero) + (maxInterval / 2) (to clear the gap).
            // Integer division 'maxInterval / 2' correctly implements floor(maxInterval / 2).
            // This is the number of seconds needed for elements in the gap to be removed
            // from both ends until the 'val's become adjacent.
            minSeconds = Math.min(minSeconds, val + maxInterval / 2);
        }

        return minSeconds;
    }
}