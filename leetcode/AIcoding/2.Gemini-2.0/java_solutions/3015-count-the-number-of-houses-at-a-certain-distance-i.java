class Solution {
    public int[] countOfPairs(int n, int x, int y) {
        int[] result = new int[n];
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                int direct = Math.abs(i - j);
                int via = Math.abs(i - x) + 1 + Math.abs(y - j);
                via = Math.min(via, Math.abs(i - y) + 1 + Math.abs(x - j));
                int dist = Math.min(direct, via);
                result[dist - 1]++;
            }
        }
        return result;
    }
}