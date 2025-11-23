class Solution {
    public boolean[] canEat(int[] candiesCount, int[][] queries) {
        int n = candiesCount.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + candiesCount[i];
        }

        boolean[] res = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int type = queries[i][0];
            int day = queries[i][1];
            int cap = queries[i][2];

            long min = day + 1;
            long max = (long) (day + 1) * cap;
            long left = prefix[type] + 1;
            long right = prefix[type + 1];

            res[i] = !(max < left || min > right);
        }
        return res;
    }
}