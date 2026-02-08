class Solution {
    public int[] platesBetweenCandles(String s, int[][] queries) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];
        int[] prefix = new int[n];

        int lastCandle = -1;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '|') {
                lastCandle = i;
            }
            left[i] = lastCandle;
        }

        lastCandle = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == '|') {
                lastCandle = i;
            }
            right[i] = lastCandle;
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '*') {
                count++;
            }
            prefix[i] = count;
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int start = queries[i][0];
            int end = queries[i][1];
            int leftCandle = right[start];
            int rightCandle = left[end];

            if (leftCandle == -1 || rightCandle == -1 || leftCandle >= rightCandle) {
                result[i] = 0;
            } else {
                result[i] = prefix[rightCandle] - prefix[leftCandle];
            }
        }
        return result;
    }
}