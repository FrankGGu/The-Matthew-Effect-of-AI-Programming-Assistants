import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public List<Integer> fallingSquares(int[][] positions) {
        List<Integer> ans = new ArrayList<>();
        // TreeMap stores (x_coordinate, height) pairs.
        // Each entry (x, h) means that the surface from x up to the next key in the map has height h.
        TreeMap<Integer, Integer> map = new TreeMap<>();
        // Initialize with ground level at height 0.
        // This ensures floorEntry always returns a value and represents the ground.
        map.put(0, 0); 

        int maxOverallHeight = 0;

        for (int[] position : positions) {
            int left = position[0];
            int side = position[1];
            int right = left + side;

            // 1. Find the maximum height of any existing surface that the current square would land on
            int max_h_below = 0;

            // Get the height of the surface just before 'left'
            Map.Entry<Integer, Integer> floorEntry = map.floorEntry(left);
            if (floorEntry != null) { // Should always be true due to map.put(0,0)
                max_h_below = Math.max(max_h_below, floorEntry.getValue());
            }

            // Iterate through all segments that start within the current square's base [left, right)
            // and find the maximum height among them.
            // subMap(fromKey, true, toKey, false) includes fromKey, excludes toKey.
            for (Map.Entry<Integer, Integer> entry : map.subMap(left, true, right, false).entrySet()) {
                max_h_below = Math.max(max_h_below, entry.getValue());
            }

            // 2. Calculate the new height of the current square
            int current_square_height = max_h_below + side;

            // 3. Update the overall maximum height seen so far
            maxOverallHeight = Math.max(maxOverallHeight, current_square_height);
            ans.add(maxOverallHeight);

            // 4. Store the height at 'right' before modifying the map for the current square.
            // This is crucial to preserve the height of the surface immediately to the right of the current square.
            int h_at_R_before_update = map.floorEntry(right).getValue();

            // 5. Remove all entries (segments) that are within the range [left, right).
            // The new square now defines the height for this entire range.
            map.keySet().subSet(left, right).clear();

            // 6. Add the new segment starting at 'left' with its new height.
            map.put(left, current_square_height);

            // 7. Restore the height at 'right'. This ensures continuity after the current square.
            // If 'right' was already a key and its height was h_at_R_before_update, this is redundant but harmless.
            // If 'right' was not a key, or its height was implicitly removed by clearing, this correctly sets it.
            map.put(right, h_at_R_before_update);
        }

        return ans;
    }
}