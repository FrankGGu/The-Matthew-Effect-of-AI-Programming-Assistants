class Solution {
    public int expressiveWords(String S, String[] words) {
        int count = 0;
        for (String word : words) {
            if (isStretchy(S, word)) {
                count++;
            }
        }
        return count;
    }

    private boolean isStretchy(String S, String word) {
        int i = 0, j = 0;
        while (i < S.length() && j < word.length()) {
            if (S.charAt(i) != word.charAt(j)) {
                return false;
            }
            int countS = 0, countW = 0;
            char currentChar = S.charAt(i);
            while (i < S.length() && S.charAt(i) == currentChar) {
                countS++;
                i++;
            }
            while (j < word.length() && word.charAt(j) == currentChar) {
                countW++;
                j++;
            }
            if (countS < countW || (countS < 3 && countS != countW)) {
                return false;
            }
        }
        return i == S.length() && j == word.length();
    }
}