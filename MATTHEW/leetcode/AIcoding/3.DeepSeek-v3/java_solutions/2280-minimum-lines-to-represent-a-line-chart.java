class Solution {
    public int minimumLines(int[][] stockPrices) {
        if (stockPrices.length <= 1) {
            return 0;
        }
        Arrays.sort(stockPrices, (a, b) -> Integer.compare(a[0], b[0]));
        int lines = 1;
        for (int i = 2; i < stockPrices.length; i++) {
            long x1 = stockPrices[i - 2][0], y1 = stockPrices[i - 2][1];
            long x2 = stockPrices[i - 1][0], y2 = stockPrices[i - 1][1];
            long x3 = stockPrices[i][0], y3 = stockPrices[i][1];
            long diff1 = (y2 - y1) * (x3 - x2);
            long diff2 = (y3 - y2) * (x2 - x1);
            if (diff1 != diff2) {
                lines++;
            }
        }
        return lines;
    }
}