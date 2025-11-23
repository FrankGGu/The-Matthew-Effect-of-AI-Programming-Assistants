class Solution {
    public int[] platesBetweenCandles(String s, int[][] queries) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];
        int[] prefixSum = new int[n + 1];

        for (int i = 0, count = 0; i < n; i++) {
            if (s.charAt(i) == '|') {
                count++;
                left[i] = i;
            } else {
                left[i] = (i > 0) ? left[i - 1] : -1;
                prefixSum[i + 1] = prefixSum[i] + 1;
            }
        }

        for (int i = n - 1, count = 0; i >= 0; i--) {
            if (s.charAt(i) == '|') {
                count++;
                right[i] = i;
            } else {
                right[i] = (i < n - 1) ? right[i + 1] : -1;
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int leftIndex = queries[i][0];
            int rightIndex = queries[i][1];

            int leftCandle = right[leftIndex];
            int rightCandle = left[rightIndex];

            if (leftCandle == -1 || rightCandle == -1 || leftCandle >= rightCandle) {
                result[i] = 0;
            } else {
                result[i] = prefixSum[rightCandle + 1] - prefixSum[leftCandle];
            }
        }

        return result;
    }
}