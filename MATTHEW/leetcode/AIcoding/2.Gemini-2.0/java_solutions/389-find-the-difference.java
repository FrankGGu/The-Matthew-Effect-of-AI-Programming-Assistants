class Solution {
    public char findTheDifference(String s, String t) {
        int[] charCount = new int[26];

        for (char c : s.toCharArray()) {
            charCount[c - 'a']++;
        }

        for (char c : t.toCharArray()) {
            charCount[c - 'a']--;
            if (charCount[c - 'a'] < 0) {
                return c;
            }
        }

        return ' ';
    }
}