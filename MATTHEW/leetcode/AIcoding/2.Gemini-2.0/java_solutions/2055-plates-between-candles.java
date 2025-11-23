class Solution {
    public int[] platesBetweenCandles(String s, int[][] queries) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];
        int[] sum = new int[n];

        int last = -1;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '|') {
                last = i;
            }
            left[i] = last;
        }

        last = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == '|') {
                last = i;
            }
            right[i] = last;
        }

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '*') {
                sum[i] = 1;
            }
            if (i > 0) {
                sum[i] += sum[i - 1];
            }
        }

        int[] ans = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int l = queries[i][0];
            int r = queries[i][1];

            int leftCandle = right[l];
            int rightCandle = left[r];

            if (leftCandle == -1 || rightCandle == -1 || leftCandle >= rightCandle) {
                ans[i] = 0;
            } else {
                ans[i] = sum[rightCandle] - sum[leftCandle];
            }
        }

        return ans;
    }
}