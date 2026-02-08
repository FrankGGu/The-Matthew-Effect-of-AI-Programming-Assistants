class Solution {
    private int count;

    public int numTilePossibilities(String tiles) {
        count = 0;
        int[] charCounts = new int[26];
        for (char c : tiles.toCharArray()) {
            charCounts[c - 'A']++;
        }

        backtrack(charCounts);
        return count;
    }

    private void backtrack(int[] charCounts) {
        for (int i = 0; i < 26; i++) {
            if (charCounts[i] > 0) {
                // Use this character
                charCounts[i]--;
                count++; // Increment count for the current unique sequence formed
                backtrack(charCounts); // Explore possibilities with remaining characters
                charCounts[i]++; // Backtrack: put the character back
            }
        }
    }
}