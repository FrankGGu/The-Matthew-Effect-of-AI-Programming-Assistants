class Solution {
    public int minTaps(int n, int[] ranges) {
        // Create an array to store the maximum reach for each starting point.
        // maxReach[i] will store the furthest point reachable if we start watering at point 'i'.
        // More precisely, maxReach[i] stores the maximum 'end' point (j + ranges[j])
        // for any tap 'j' such that its 'start' point (j - ranges[j]) is 'i'.
        // If multiple taps start at 'i', we take the one that reaches furthest.
        int[] maxReach = new int[n + 1];

        for (int i = 0; i <= n; i++) {
            // Calculate the effective start and end points for the current tap 'i'.
            int start = Math.max(0, i - ranges[i]);
            int end = i + ranges[i];

            // Update maxReach for the 'start' point.
            // We want to store the maximum 'end' point for a given 'start'.
            maxReach[start] = Math.max(maxReach[start], end);
        }

        int taps = 0;
        int currentMaxCoverage = 0; // The rightmost point currently covered by selected taps.
        int nextMaxCoverage = 0;    // The rightmost point reachable if we open one more tap.

        // Iterate through the garden from point 0 to n.
        for (int i = 0; i <= n; i++) {
            // If the current point 'i' is beyond what we can currently cover,
            // it means there's a gap that cannot be watered.
            if (i > currentMaxCoverage) {
                return -1;
            }

            // Update 'nextMaxCoverage' with the maximum reach from any tap
            // whose starting point is 'i' or earlier.
            // This effectively finds the tap that extends furthest to the right
            // from the current segment we are considering.
            nextMaxCoverage = Math.max(nextMaxCoverage, maxReach[i]);

            // If we have reached the limit of our current tap's coverage,
            // we must open a new tap to extend coverage.
            if (i == currentMaxCoverage) {
                taps++;
                currentMaxCoverage = nextMaxCoverage; // Update to the new furthest reach.
            }

            // If the entire garden [0, n] is covered, return the number of taps.
            if (currentMaxCoverage >= n) {
                return taps;
            }
        }

        // This line should ideally not be reached if the problem guarantees a solution or if
        // the loop condition `currentMaxCoverage >= n` handles all cases.
        // However, if `n` is 0 and `ranges[0]` is 0, `currentMaxCoverage` will be 0,
        // and loop finishes, `taps` will be 1. The problem implies `[0,n]` needs to be covered.
        // If `n=0`, then `currentMaxCoverage >= n` (0 >= 0) is true in the first iteration.
        // So, this return is just a fallback.
        return taps;
    }
}