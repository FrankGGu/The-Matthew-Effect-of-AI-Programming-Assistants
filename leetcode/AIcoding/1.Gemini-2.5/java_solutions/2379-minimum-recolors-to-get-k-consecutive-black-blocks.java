class Solution {
    public int minimumRecolors(String blocks, int k) {
        int n = blocks.length();
        int currentWhites = 0;

        // Calculate whites in the first window
        for (int i = 0; i < k; i++) {
            if (blocks.charAt(i) == 'W') {
                currentWhites++;
            }
        }

        int minWhites = currentWhites;

        // Slide the window
        for (int i = k; i < n; i++) {
            // Remove the character leaving the window
            if (blocks.charAt(i - k) == 'W') {
                currentWhites--;
            }
            // Add the character entering the window
            if (blocks.charAt(i) == 'W') {
                currentWhites++;
            }
            minWhites = Math.min(minWhites, currentWhites);
        }

        return minWhites;
    }
}