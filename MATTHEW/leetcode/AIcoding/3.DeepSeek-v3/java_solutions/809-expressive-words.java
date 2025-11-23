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
            int countS = 1;
            while (i + 1 < S.length() && S.charAt(i) == S.charAt(i + 1)) {
                i++;
                countS++;
            }
            int countW = 1;
            while (j + 1 < word.length() && word.charAt(j) == word.charAt(j + 1)) {
                j++;
                countW++;
            }
            if (countS < countW || (countS < 3 && countS != countW)) {
                return false;
            }
            i++;
            j++;
        }
        return i == S.length() && j == word.length();
    }
}