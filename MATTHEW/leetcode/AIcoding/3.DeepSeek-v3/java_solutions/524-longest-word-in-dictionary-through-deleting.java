import java.util.List;

class Solution {
    public String findLongestWord(String s, List<String> dictionary) {
        String longestWord = "";
        for (String word : dictionary) {
            if (isSubsequence(word, s)) {
                if (word.length() > longestWord.length() || 
                    (word.length() == longestWord.length() && word.compareTo(longestWord) < 0)) {
                    longestWord = word;
                }
            }
        }
        return longestWord;
    }

    private boolean isSubsequence(String word, String s) {
        int i = 0, j = 0;
        while (i < word.length() && j < s.length()) {
            if (word.charAt(i) == s.charAt(j)) {
                i++;
            }
            j++;
        }
        return i == word.length();
    }
}