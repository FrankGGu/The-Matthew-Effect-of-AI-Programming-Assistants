import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int countCoveredBuildings(int[][] buildings) {
        // Sort the buildings:
        // Primary sort key: x-coordinate in ascending order.
        // Secondary sort key (for ties in x-coordinate): height in descending order.
        // This sorting strategy is crucial. It ensures that when we iterate,
        // if multiple buildings share the same x-coordinate, the tallest one
        // is processed first. This allows it to "cover" any shorter buildings
        // at the same x-coordinate that come after it in the sorted list.
        Arrays.sort(buildings, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0]; // Sort by x-coordinate ascending
            } else {
                return b[1] - a[1]; // If x-coordinates are equal, sort by height descending
            }
        });

        int n = buildings.length;
        int uncoveredCount = 0;
        // maxHSoFar keeps track of the maximum height encountered among buildings
        // processed so far that are not covered.
        // Initialize with 0, as building heights are positive (1 to 10^9).
        int maxHSoFar = 0; 

        for (int i = 0; i < n; i++) {
            int currentH = buildings[i][1];

            // A building is considered "uncovered" if its height is strictly greater
            // than the maximum height of any building processed before it (which would
            // have an x-coordinate less than or equal to the current building's x-coordinate).
            // Due to the sorting:
            // - If currentH > maxHSoFar, no previous building (with x_prev <= currentX)
            //   could have covered the current building, because no such previous building
            //   had a height greater than or equal to currentH.
            // - If currentH <= maxHSoFar, it means there exists at least one previous building
            //   (say, building J) that contributed to maxHSoFar. This building J has:
            //   1. X_J <= currentX (guaranteed by sort order).
            //   2. H_J = maxHSoFar >= currentH (guaranteed by definition of maxHSoFar and condition).
            //   Thus, building J covers the current building.
            if (currentH > maxHSoFar) {
                uncoveredCount++;
                maxHSoFar = currentH; // Update maxHSoFar with the new dominant height
            }
        }

        // The problem asks for the count of *covered* buildings.
        // We have calculated the count of *uncovered* buildings.
        // The total number of buildings minus the number of uncovered buildings
        // gives the number of covered buildings.
        return n - uncoveredCount;
    }
}