class DetectSquares {

    private int[][] cnt;

    public DetectSquares() {
        cnt = new int[1001][1001];
    }

    public void add(int[] point) {
        cnt[point[0]][point[1]]++;
    }

    public int count(int[] point) {
        int x = point[0], y = point[1];
        int ans = 0;
        for (int i = 1; i <= 1000; i++) {
            if (cnt[i][y] > 0) {
                int len = Math.abs(i - x);
                if (len > 0 && y + len <= 1000) {
                    ans += cnt[i][y] * cnt[x][y + len] * cnt[i][y + len];
                }
                if (len > 0 && y - len >= 0) {
                    ans += cnt[i][y] * cnt[x][y - len] * cnt[i][y - len];
                }
            }
        }
        return ans;
    }
}