class Solution {
    public int[] platesBetweenCandles(String s, int[][] queries) {
        int n = s.length();

        int[] nextCandle = new int[n];
        int[] prevCandle = new int[n];
        int[] prefixPlates = new int[n + 1];

        int lastCandleIdx = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == '|') {
                lastCandleIdx = i;
            }
            nextCandle[i] = lastCandleIdx;
        }

        int firstCandleIdx = -1;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '|') {
                firstCandleIdx = i;
            }
            prevCandle[i] = firstCandleIdx;
        }

        prefixPlates[0] = 0;
        for (int i = 0; i < n; i++) {
            prefixPlates[i + 1] = prefixPlates[i] + (s.charAt(i) == '*' ? 1 : 0);
        }

        int[] ans = new int[queries.length];

        for (int qIdx = 0; qIdx < queries.length; qIdx++) {
            int left = queries[qIdx][0];
            int right = queries[qIdx][1];

            int actualFirstCandle = nextCandle[left];
            int actualLastCandle = prevCandle[right];

            if (actualFirstCandle == -1 || actualLastCandle == -1 || actualFirstCandle >= actualLastCandle) {
                ans[qIdx] = 0;
            } else {
                ans[qIdx] = prefixPlates[actualLastCandle] - prefixPlates[actualFirstCandle + 1];
            }
        }

        return ans;
    }
}