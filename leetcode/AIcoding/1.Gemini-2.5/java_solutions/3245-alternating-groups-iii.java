class Solution {
    public int numberOfAlternatingGroups(int[] colors, int k) {
        int n = colors.length;
        if (k == 1) {
            return n;
        }

        int[] extendedColors = new int[n + k - 1];
        for (int i = 0; i < n; i++) {
            extendedColors[i] = colors[i];
        }
        for (int i = 0; i < k - 1; i++) {
            extendedColors[n + i] = colors[i];
        }

        int alternatingGroupsCount = 0;
        int currentAlternatingPairs = 0;

        // Calculate alternating pairs for the first window
        // The window covers indices [0, k-1] in extendedColors
        // It has k-1 pairs: (0,1), (1,2), ..., (k-2, k-1)
        for (int j = 0; j < k - 1; j++) {
            if (extendedColors[j] != extendedColors[j+1]) {
                currentAlternatingPairs++;
            }
        }

        if (currentAlternatingPairs == k - 1) {
            alternatingGroupsCount++;
        }

        // Slide the window
        // The window starts at original index `i` in `colors`
        // which corresponds to index `i` in `extendedColors`
        // and ends at original index `(i+k-1)%n` in `colors`
        // which corresponds to index `i+k-1` in `extendedColors`
        for (int i = 1; i < n; i++) {
            // Remove the pair that leaves the window from the left
            // This is the pair (extendedColors[i-1], extendedColors[i])
            if (extendedColors[i-1] != extendedColors[i]) {
                currentAlternatingPairs--;
            }
            // Add the pair that enters the window from the right
            // This is the pair (extendedColors[i+k-2], extendedColors[i+k-1])
            if (extendedColors[i+k-2] != extendedColors[i+k-1]) {
                currentAlternatingPairs++;
            }

            if (currentAlternatingPairs == k - 1) {
                alternatingGroupsCount++;
            }
        }

        return alternatingGroupsCount;
    }
}