class Solution {
    public int countSubstrings(String s, int k) {
        int n = s.length();
        int totalCount = 0;

        for (int i = 0; i < n; i++) {
            int[] freq = new int[26]; // Frequency map for characters in s[i...j]
            int uniqueChars = 0;      // Number of unique characters in s[i...j]
            int charsMeetingK = 0;    // Number of unique characters that appear at least k times

            for (int j = i; j < n; j++) {
                int charIndex = s.charAt(j) - 'a';

                // If this character is seen for the first time in the current substring s[i...j]
                if (freq[charIndex] == 0) {
                    uniqueChars++;
                }

                freq[charIndex]++;

                // If this character's frequency just reached k
                if (freq[charIndex] == k) {
                    charsMeetingK++;
                }

                // A substring s[i...j] is valid if all its unique characters appear at least k times.
                // This condition is met when the count of unique characters equals the count of characters
                // that have a frequency of at least k.
                if (uniqueChars == charsMeetingK) {
                    totalCount++;
                }
            }
        }
        return totalCount;
    }
}