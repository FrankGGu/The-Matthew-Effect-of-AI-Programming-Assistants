class Solution {
    public int numMatchingSubseq(String s, String[] words) {
        int count = 0;
        for (String word : words) {
            if (isSubsequence(word, s)) {
                count++;
            }
        }
        return count;
    }

    private boolean isSubsequence(String word, String s) {
        int i = 0;
        int j = 0;
        while (i < word.length() && j < s.length()) {
            if (word.charAt(i) == s.charAt(j)) {
                i++;
            }
            j++;
        }
        return i == word.length();
    }
}