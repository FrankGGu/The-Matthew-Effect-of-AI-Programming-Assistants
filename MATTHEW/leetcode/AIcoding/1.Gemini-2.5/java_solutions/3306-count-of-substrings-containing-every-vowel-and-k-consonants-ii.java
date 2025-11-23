import java.util.Arrays;

class Solution {
    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    private int getVowelIndex(char c) {
        if (c == 'a') return 0;
        if (c == 'e') return 1;
        if (c == 'i') return 2;
        if (c == 'o') return 3;
        if (c == 'u') return 4;
        return -1; // Should not happen for valid vowels
    }

    public long countOfSubstrings(String s, int k) {
        return solve(s, k) - solve(s, k - 1);
    }

    private long solve(String s, int k_max) {
        int n = s.length();
        long count = 0;

        int[] vowelFreq = new int[5]; // Frequencies of 'a', 'e', 'i', 'o', 'u'
        int uniqueVowelCount = 0;
        int consonantCount = 0;

        int left = 0; // Left pointer for the main window [left, right]
        int targetUniqueVowels = 5;

        for (int right = 0; right < n; right++) {
            char currentChar = s.charAt(right);

            // Add current character to the window [left, right]
            if (isVowel(currentChar)) {
                int idx = getVowelIndex(currentChar);
                if (vowelFreq[idx] == 0) {
                    uniqueVowelCount++;
                }
                vowelFreq[idx]++;
            } else {
                consonantCount++;
            }

            // Shrink the window from 'left' if consonantCount exceeds k_max
            // This ensures s[left...right] always has consonantCount <= k_max
            while (consonantCount > k_max) {
                char leftChar = s.charAt(left);
                if (isVowel(leftChar)) {
                    int idx = getVowelIndex(leftChar);
                    vowelFreq[idx]--;
                    if (vowelFreq[idx] == 0) {
                        uniqueVowelCount--;
                    }
                } else {
                    consonantCount--;
                }
                left++;
            }

            // At this point, the window s[left...right] satisfies consonantCount <= k_max.
            // We need to count substrings s[p...right] where left <= p <= right
            // that also satisfy uniqueVowelCount == targetUniqueVowels.

            // If the current window [left, right] does not have all 5 unique vowels,
            // then no substring starting at or after 'left' and ending at 'right' will.
            if (uniqueVowelCount < targetUniqueVowels) {
                continue;
            }

            // If uniqueVowelCount == targetUniqueVowels for s[left...right],
            // we need to find the leftmost possible starting point `p_vowel_start`
            // such that s[p_vowel_start...right] still contains all 5 unique vowels.
            // This is done by a temporary inner pointer `tempLeftVowelShrink`.

            // Create temporary copies of vowel counts to simulate shrinking from `left`
            // without affecting the main window's `vowelFreq` and `uniqueVowelCount`.
            int[] tempVowelFreq = Arrays.copyOf(vowelFreq, 5);
            int tempUniqueVowelCount = uniqueVowelCount;
            int tempLeftVowelShrink = left;

            // Shrink `tempLeftVowelShrink` from `left` as much as possible
            // while maintaining `tempUniqueVowelCount == targetUniqueVowels`.
            while (tempUniqueVowelCount == targetUniqueVowels && tempLeftVowelShrink <= right) {
                char tempChar = s.charAt(tempLeftVowelShrink);
                if (isVowel(tempChar)) {
                    int idx = getVowelIndex(tempChar);
                    tempVowelFreq[idx]--;
                    if (tempVowelFreq[idx] == 0) {
                        tempUniqueVowelCount--;
                    }
                }
                tempLeftVowelShrink++;
            }
            // After the loop, `tempLeftVowelShrink` is one position past the valid start.
            // So, `tempLeftVowelShrink - 1` is the actual leftmost index `p`
            // such that `s[p...right]` has all 5 unique vowels.
            // Any `p` from `left` up to `tempLeftVowelShrink - 1` will work.
            // The number of such `p` values is `(tempLeftVowelShrink - 1) - left + 1`
            // which simplifies to `tempLeftVowelShrink - left`.
            count += (tempLeftVowelShrink - left);
        }
        return count;
    }
}