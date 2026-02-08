class Solution {
    public long appealSum(String s) {
        long totalAppeal = 0;
        int n = s.length();
        int[] lastSeen = new int[26]; // Stores the last seen index for each character 'a' through 'z'

        // Initialize lastSeen array with -1, indicating no character has been seen yet
        for (int i = 0; i < 26; i++) {
            lastSeen[i] = -1;
        }

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            int charIndex = c - 'a';

            // The number of substrings ending at 'i' where 's[i]' is the first occurrence
            // of character 'c' is (i - lastSeen[charIndex]).
            // These substrings can start from any index j such that lastSeen[charIndex] < j <= i.
            long numWaysToStart = i - lastSeen[charIndex];

            // The number of ways to end a substring starting at or before 'i' and containing 's[i]'
            // is (n - i). These substrings can end at any index k such that i <= k < n.
            long numWaysToEnd = n - i;

            // The total contribution of s[i] to the appeal sum is the product of
            // numWaysToStart and numWaysToEnd.
            totalAppeal += numWaysToStart * numWaysToEnd;

            // Update the last seen index for the current character
            lastSeen[charIndex] = i;
        }

        return totalAppeal;
    }
}