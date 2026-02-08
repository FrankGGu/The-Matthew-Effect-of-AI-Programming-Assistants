class Solution {
    public int countCells(String s, String t) {
        int m = s.length(), n = t.length();
        boolean[][] count = new boolean[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (s.charAt(i) == t.charAt(j)) {
                    count[i][j] = true;
                }
            }
        }
        int totalCount = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (count[i][j]) {
                    totalCount++;
                }
            }
        }
        return totalCount;
    }
}