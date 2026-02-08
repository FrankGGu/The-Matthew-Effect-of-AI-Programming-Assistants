import java.util.Arrays;

class Solution {
    public boolean closeStrings(String word1, String word2) {
        if (word1.length() != word2.length()) {
            return false;
        }

        int[] freq1 = new int[26];
        int[] freq2 = new int[26];

        for (char c : word1.toCharArray()) {
            freq1[c - 'a']++;
        }

        for (char c : word2.toCharArray()) {
            freq2[c - 'a']++;
        }

        // Condition 1: Both strings must contain the same set of unique characters.
        for (int i = 0; i < 26; i++) {
            if ((freq1[i] > 0 && freq2[i] == 0) || (freq1[i] == 0 && freq2[i] > 0)) {
                return false;
            }
        }

        // Condition 2: The counts of characters, when sorted, must be the same.
        // This means the multiset of frequencies must be identical.
        Arrays.sort(freq1);
        Arrays.sort(freq2);

        for (int i = 0; i < 26; i++) {
            if (freq1[i] != freq2[i]) {
                return false;
            }
        }

        return true;
    }
}