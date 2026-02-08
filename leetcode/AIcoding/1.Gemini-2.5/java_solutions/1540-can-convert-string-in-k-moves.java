class Solution {
    public boolean canConvertString(String s, String t, int k) {
        if (s.length() != t.length()) {
            return false;
        }

        // counts[i] stores how many times we've encountered a required shift of 'i' (1 to 25).
        // This helps in calculating the actual number of moves for subsequent occurrences of the same shift.
        int[] counts = new int[26];

        for (int i = 0; i < s.length(); i++) {
            char charS = s.charAt(i);
            char charT = t.charAt(i);

            if (charS == charT) {
                continue;
            }

            // Calculate the required shift (1 to 25)
            // Example: 'a' to 'c' is 2. 'z' to 'a' is 1.
            int diff = (charT - charS + 26) % 26;

            // Calculate the total moves needed for this specific character conversion.
            // If diff = 1, first time: 1 move. Second time: 1 + 26 = 27 moves. Third time: 1 + 2*26 = 53 moves.
            // This is diff + counts[diff] * 26.
            long totalMoves = (long)diff + (long)counts[diff] * 26L;

            if (totalMoves > k) {
                return false;
            }

            // Increment the count for this specific shift.
            counts[diff]++;
        }

        return true;
    }
}