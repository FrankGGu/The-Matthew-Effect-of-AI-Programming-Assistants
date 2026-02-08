class Solution {
    public int minCharacters(String a, String b) {
        int[] freqA = new int[26];
        int[] freqB = new int[26];

        for (char c : a.toCharArray()) {
            freqA[c - 'a']++;
        }
        for (char c : b.toCharArray()) {
            freqB[c - 'a']++;
        }

        int[] pa = new int[26]; // prefix sum for a
        int[] pb = new int[26]; // prefix sum for b

        pa[0] = freqA[0];
        pb[0] = freqB[0];
        for (int i = 1; i < 26; i++) {
            pa[i] = pa[i - 1] + freqA[i];
            pb[i] = pb[i - 1] + freqB[i];
        }

        int minChanges = Integer.MAX_VALUE;

        // Condition 1: Every character in a is strictly less than every character in b.
        // This means there exists a character 'x' (from 'a' to 'y') such that
        // all chars in a are <= 'x' and all chars in b are > 'x'.
        for (int x_idx = 0; x_idx < 25; x_idx++) { // 'x' from 'a' (0) to 'y' (24)
            // Chars in a that are > 'x' must be changed.
            int changesA = a.length() - pa[x_idx];
            // Chars in b that are <= 'x' must be changed.
            int changesB = pb[x_idx];
            minChanges = Math.min(minChanges, changesA + changesB);
        }

        // Condition 2: Every character in b is strictly less than every character in a.
        // Symmetric to Condition 1.
        for (int x_idx = 0; x_idx < 25; x_idx++) { // 'x' from 'a' (0) to 'y' (24)
            // Chars in b that are > 'x' must be changed.
            int changesB = b.length() - pb[x_idx];
            // Chars in a that are <= 'x' must be changed.
            int changesA = pa[x_idx];
            minChanges = Math.min(minChanges, changesA + changesB);
        }

        // Condition 3: Both strings a and b consist of only one distinct character.
        // This means both strings become all 'x' for some 'x' (from 'a' to 'z').
        for (int x_idx = 0; x_idx < 26; x_idx++) { // 'x' from 'a' (0) to 'z' (25)
            // Chars in a not equal to 'x' must be changed.
            int changesA = a.length() - freqA[x_idx];
            // Chars in b not equal to 'x' must be changed.
            int changesB = b.length() - freqB[x_idx];
            minChanges = Math.min(minChanges, changesA + changesB);
        }

        return minChanges;
    }
}