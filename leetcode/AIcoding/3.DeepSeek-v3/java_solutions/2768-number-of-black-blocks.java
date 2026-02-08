class Solution {
    public long[] countBlackBlocks(int m, int n, int[][] coordinates) {
        Map<Long, Integer> count = new HashMap<>();
        long[] res = new long[5];
        res[0] = (long)(m - 1) * (n - 1);

        for (int[] coord : coordinates) {
            int x = coord[0], y = coord[1];
            for (int i = Math.max(0, x - 1); i <= Math.min(m - 2, x); i++) {
                for (int j = Math.max(0, y - 1); j <= Math.min(n - 2, y); j++) {
                    long key = (long)i * 100000 + j;
                    int cnt = count.getOrDefault(key, 0);
                    res[cnt]--;
                    res[cnt + 1]++;
                    count.put(key, cnt + 1);
                }
            }
        }

        return res;
    }
}