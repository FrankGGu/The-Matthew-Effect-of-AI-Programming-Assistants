class Solution {
    public int maxDistance(int[] colors) {
        int n = colors.length;
        int maxDist = 0;

        // Check distance from the first house (index 0)
        // Iterate from the last house towards the first to find the furthest house with a different color
        for (int j = n - 1; j > 0; j--) {
            if (colors[0] != colors[j]) {
                maxDist = Math.max(maxDist, j); // Distance is j - 0
                break; // Found the largest possible distance involving house 0
            }
        }

        // Check distance from the last house (index n-1)
        // Iterate from the first house towards the last to find the furthest house with a different color
        for (int i = 0; i < n - 1; i++) {
            if (colors[n - 1] != colors[i]) {
                maxDist = Math.max(maxDist, (n - 1) - i); // Distance is (n-1) - i
                break; // Found the largest possible distance involving house n-1
            }
        }

        return maxDist;
    }
}