import java.util.Arrays;

public class Solution {
    public int minimumLines(int[][] stockPrices) {
        Arrays.sort(stockPrices, (a, b) -> a[0] - b[0]);
        int lines = 0;
        long prevX = stockPrices[0][0], prevY = stockPrices[0][1];

        for (int i = 1; i < stockPrices.length; i++) {
            long currX = stockPrices[i][0], currY = stockPrices[i][1];
            if (lines == 0 || (currY - prevY) * (currX - stockPrices[i - 1][0]) != (currX - prevX) * (currY - stockPrices[i - 1][1])) {
                lines++;
            }
            prevX = currX;
            prevY = currY;
        }

        return lines;
    }
}