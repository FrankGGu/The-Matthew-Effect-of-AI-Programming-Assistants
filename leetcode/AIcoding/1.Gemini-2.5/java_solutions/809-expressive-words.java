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

    private boolean isStretchy(String S, String W) {
        int i = 0, j = 0;
        int n = S.length();
        int m = W.length();

        while (i < n && j < m) {
            if (S.charAt(i) != W.charAt(j)) {
                return false;
            }

            char currentChar = S.charAt(i);
            int countS = 0;
            while (i < n && S.charAt(i) == currentChar) {
                countS++;
                i++;
            }

            int countW = 0;
            while (j < m && W.charAt(j) == currentChar) {
                countW++;
                j++;
            }

            if (countS < countW) {
                return false;
            }

            if (countS < 3 && countS != countW) {
                return false;
            }
        }

        return i == n && j == m;
    }
}