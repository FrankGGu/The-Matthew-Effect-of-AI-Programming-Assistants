class Solution {
    public int numberOfSpecialChars(String word) {
        int[] lower = new int[26];
        int[] upper = new int[26];
        int count = 0;

        for (char c : word.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                lower[c - 'a']++;
            } else if (c >= 'A' && c <= 'Z') {
                upper[c - 'A']++;
            }
        }

        for (int i = 0; i < 26; i++) {
            if (lower[i] > 0 && upper[i] > 0) {
                count++;
            }
        }

        return count;
    }
}