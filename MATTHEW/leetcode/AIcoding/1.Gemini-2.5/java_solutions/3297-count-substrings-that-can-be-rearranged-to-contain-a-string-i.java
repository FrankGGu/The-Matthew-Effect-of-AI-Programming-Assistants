class Solution {
    public long numberOfSubstrings(String s) {
        long count = 0;
        int[] charCounts = new int[3]; // 0 for 'a', 1 for 'b', 2 for 'c'
        int left = 0;
        int n = s.length();

        for (int right = 0; right < n; right++) {
            charCounts[s.charAt(right) - 'a']++;

            while (charCounts[0] > 0 && charCounts[1] > 0 && charCounts[2] > 0) {
                // If the window [left, right] contains at least one 'a', 'b', and 'c',
                // then any substring starting at 'left' and ending at 'right' or beyond
                // (up to n-1) will also contain 'a', 'b', and 'c'.
                // There are (n - right) such substrings.
                count += (n - right);

                // Shrink the window from the left
                charCounts[s.charAt(left) - 'a']--;
                left++;
            }
        }

        return count;
    }
}