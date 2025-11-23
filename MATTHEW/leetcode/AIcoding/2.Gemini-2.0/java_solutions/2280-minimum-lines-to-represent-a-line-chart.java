import java.util.Arrays;

class Solution {
    public int minimumLines(int[][] stockPrices) {
        if (stockPrices.length <= 1) {
            return 0;
        }

        Arrays.sort(stockPrices, (a, b) -> a[0] - b[0]);

        int lines = 1;
        for (int i = 2; i < stockPrices.length; i++) {
            if (!isCollinear(stockPrices[i - 2], stockPrices[i - 1], stockPrices[i])) {
                lines++;
            }
        }

        return lines;
    }

    private boolean isCollinear(int[] p1, int[] p2, int[] p3) {
        return (long) (p2[1] - p1[1]) * (p3[0] - p2[0]) == (long) (p3[1] - p2[1]) * (p2[0] - p1[0]);
    }
}