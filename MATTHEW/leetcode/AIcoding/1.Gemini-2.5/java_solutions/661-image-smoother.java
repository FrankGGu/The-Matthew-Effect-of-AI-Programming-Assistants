class Solution {
    public int[][] imageSmoother(int[][] img) {
        int m = img.length;
        int n = img[0].length;
        int[][] ans = new int[m][n];

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int sum = 0;
                int count = 0;

                for (int nr = r - 1; nr <= r + 1; nr++) {
                    for (int nc = c - 1; nc <= c + 1; nc++) {
                        if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                            sum += img[nr][nc];
                            count++;
                        }
                    }
                }
                ans[r][c] = sum / count;
            }
        }
        return ans;
    }
}