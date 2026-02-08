class Solution {
    public int[] countOfPairs(int n, int x, int y) {
        int[] res = new int[n];
        for (int i = 1; i <= n; i++) {
            for (int j = i + 1; j <= n; j++) {
                int d = Math.min(Math.abs(i - j), Math.abs(i - x) + 1 + Math.abs(y - j));
                d = Math.min(d, Math.abs(i - y) + 1 + Math.abs(x - j));
                res[d - 1] += 2;
            }
        }
        return res;
    }
}