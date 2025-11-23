class Solution {
    public int[] countServers(int n, int[][] logs, int x, int[] queries) {
        Arrays.sort(logs, (a, b) -> a[1] - b[1]);
        int m = queries.length;
        int[][] qs = new int[m][2];
        for (int i = 0; i < m; ++i) {
            qs[i] = new int[] {queries[i], i};
        }
        Arrays.sort(qs, (a, b) -> a[0] - b[0]);
        int[] ans = new int[m];
        Map<Integer, Integer> cnt = new HashMap<>();
        int i = 0, j = 0;
        for (int[] q : qs) {
            int r = q[0], l = r - x;
            int k = q[1];
            while (i < logs.length && logs[i][1] <= r) {
                cnt.put(logs[i][0], cnt.getOrDefault(logs[i][0], 0) + 1);
                ++i;
            }
            while (j < logs.length && logs[j][1] < l) {
                int t = logs[j][0];
                cnt.put(t, cnt.get(t) - 1);
                if (cnt.get(t) == 0) {
                    cnt.remove(t);
                }
                ++j;
            }
            ans[k] = n - cnt.size();
        }
        return ans;
    }
}