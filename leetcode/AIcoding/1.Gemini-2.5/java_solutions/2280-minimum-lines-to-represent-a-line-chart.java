import java.util.Arrays;

class Solution {
    public int minimumLines(int[][] stockPrices) {
        if (stockPrices.length <= 1) {
            return 0;
        }
        if (stockPrices.length == 2) {
            return 1;
        }

        Arrays.sort(stockPrices, (a, b) -> Integer.compare(a[0], b[0]));

        int lines = 1;

        for (int i = 2; i < stockPrices.length; i++) {
            long x1 = stockPrices[i - 2][0];
            long y1 = stockPrices[i - 2][1];
            long x2 = stockPrices[i - 1][0];
            long y2 = stockPrices[i - 1][1];
            long x3 = stockPrices[i][0];
            long y3 = stockPrices[i][1];

            // Check for collinearity using cross-product:
            // (y2 - y1) * (x3 - x2) == (y3 - y2) * (x2 - x1)
            // This avoids division and floating-point issues.
            if ((y2 - y1) * (x3 - x2) != (y3 - y2) * (x2 - x1)) {
                lines++;
            }
        }

        return lines;
    }
}