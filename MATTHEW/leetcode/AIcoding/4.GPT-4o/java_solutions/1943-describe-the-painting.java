class Solution {
    public String describePainting(int[][] painting) {
        StringBuilder result = new StringBuilder();
        int n = painting.length;
        int m = painting[0].length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (painting[i][j] != 0) {
                    int count = 0;
                    while (j < m && painting[i][j] != 0) {
                        count++;
                        j++;
                    }
                    result.append(count).append(" ").append(painting[i][j - 1]).append(" ");
                }
            }
        }
        return result.toString().trim();
    }
}