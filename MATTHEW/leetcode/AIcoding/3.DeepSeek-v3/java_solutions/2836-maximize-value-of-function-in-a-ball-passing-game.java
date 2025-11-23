class Solution {
    public long getMaxFunctionValue(List<Integer> receiver, long k) {
        int n = receiver.size();
        int m = 64 - Long.numberOfLeadingZeros(k);
        int[][] next = new int[m][n];
        long[][] sum = new long[m][n];

        for (int i = 0; i < n; i++) {
            next[0][i] = receiver.get(i);
            sum[0][i] = receiver.get(i);
        }

        for (int j = 1; j < m; j++) {
            for (int i = 0; i < n; i++) {
                next[j][i] = next[j-1][next[j-1][i]];
                sum[j][i] = sum[j-1][i] + sum[j-1][next[j-1][i]];
            }
        }

        long max = 0;
        for (int i = 0; i < n; i++) {
            long currentSum = i;
            int pos = i;
            for (int j = 0; j < m; j++) {
                if (((k >> j) & 1) != 0) {
                    currentSum += sum[j][pos];
                    pos = next[j][pos];
                }
            }
            max = Math.max(max, currentSum);
        }
        return max;
    }
}