class Solution {
    public String findLongestWord(String s, List<String> dictionary) {
        String longestWord = "";

        for (String word : dictionary) {
            if (isSubsequence(s, word)) {
                if (word.length() > longestWord.length()) {
                    longestWord = word;
                } else if (word.length() == longestWord.length()) {
                    if (word.compareTo(longestWord) < 0) {
                        longestWord = word;
                    }
                }
            }
        }

        return longestWord;
    }

    private boolean isSubsequence(String s, String t) {
        int i = 0; // pointer for s
        int j = 0; // pointer for t

        while (i < s.length() && j < t.length()) {
            if (s.charAt(i) == t.charAt(j)) {
                j++;
            }
            i++;
        }

        return j == t.length();
    }
}