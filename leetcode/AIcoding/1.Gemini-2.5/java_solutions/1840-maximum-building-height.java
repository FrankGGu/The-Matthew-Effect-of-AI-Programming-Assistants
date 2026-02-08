import java.util.*;

class Solution {
    public int maxBuilding(int n, int[][] restrictions) {
        // Use a TreeMap to store restrictions, handling potential duplicate IDs
        // by keeping the minimum maxHeight for a given ID, and ensuring sorted order by ID.
        // Key: building ID, Value: max height
        TreeMap<Integer, Integer> map = new TreeMap<>();
        map.put(1, 0); // Building 1 must have height 0

        for (int[] r : restrictions) {
            // If an ID is already in the map, take the minimum of the existing maxHeight and the new one.
            // This handles cases where the input restrictions might contain a stricter limit.
            // For building 1, this ensures its height remains 0 even if a restriction [1, X] with X > 0 is provided.
            map.put(r[0], Math.min(map.getOrDefault(r[0], Integer.MAX_VALUE), r[1]));
        }

        // Convert TreeMap entries to a List of int arrays for indexed access.
        List<int[]> processedRestrictions = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
            processedRestrictions.add(new int[]{entry.getKey(), entry.getValue()});
        }

        // Add a virtual restriction for building 'n' if it's not already present.
        // This ensures the last segment (from the last actual restriction to building 'n')
        // is properly considered for maximum height.
        // Using Integer.MAX_VALUE allows the two-pass algorithm to correctly constrain it
        // based on the previous restriction and adjacency rules.
        if (processedRestrictions.get(processedRestrictions.size() - 1)[0] != n) {
            processedRestrictions.add(new int[]{n, Integer.MAX_VALUE});
        }

        // Forward Pass (Left-to-Right):
        // Adjust max heights based on the left neighbor and the adjacency rule.
        // For each building i, its height cannot exceed (height of building i-1) + (id_i - id_{i-1}).
        for (int i = 1; i < processedRestrictions.size(); i++) {
            int[] prev = processedRestrictions.get(i - 1);
            int[] curr = processedRestrictions.get(i);
            // curr[1] (current max height) = min(original_max_height, prev[1] + (curr[0] - prev[0]))
            curr[1] = Math.min(curr[1], prev[1] + (curr[0] - prev[0]));
        }

        // Backward Pass (Right-to-Left):
        // Further adjust max heights based on the right neighbor and the adjacency rule.
        // For each building i, its height cannot exceed (height of building i+1) + (id_{i+1} - id_i).
        for (int i = processedRestrictions.size() - 2; i >= 0; i--) {
            int[] curr = processedRestrictions.get(i);
            int[] next = processedRestrictions.get(i + 1);
            // curr[1] (height after forward pass) = min(height_after_forward_pass, next[1] + (next[0] - curr[0]))
            curr[1] = Math.min(curr[1], next[1] + (next[0] - curr[0]));
        }

        // Calculate the maximum possible height for any building, including those between restricted ones.
        int maxOverallHeight = 0;
        for (int i = 0; i < processedRestrictions.size() - 1; i++) {
            int[] p1 = processedRestrictions.get(i);
            int[] p2 = processedRestrictions.get(i + 1);

            int id1 = p1[0];
            int h1 = p1[1];
            int id2 = p2[0];
            int h2 = p2[1];

            // The maximum height in the segment [id1, id2] is achieved at a "peak".
            // The height profile between two restricted buildings (id1, h1) and (id2, h2)
            // forms a trapezoid (or triangle).
            // The peak height can be calculated using the formula:
            // max(h1, h2) + floor((distance - abs(h1-h2)) / 2)
            // This formula is valid because after the two passes, we are guaranteed that
            // abs(h1 - h2) <= (id2 - id1), meaning the slope constraint is satisfied.
            int distance = id2 - id1;
            int peakHeight = Math.max(h1, h2) + (distance - Math.abs(h1 - h2)) / 2;

            maxOverallHeight = Math.max(maxOverallHeight, peakHeight);
        }

        // If there's only one restricted building (e.g., n=1 or only [1,0] and [n, MAX_VAL] got simplified),
        // the loop above won't run. In this case, the max height is simply the height of the single building.
        // The maxOverallHeight is initialized to 0, which is correct for building 1.
        // If n > 1 and only [1,0] and [n, n-1] are left, maxOverallHeight will be n-1.
        // So, the current logic correctly covers all cases.

        return maxOverallHeight;
    }
}