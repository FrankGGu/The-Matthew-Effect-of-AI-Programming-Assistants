import java.util.*;

public class Solution {
    public long[] getDistances(int[][] pieces) {
        int n = pieces.length;
        long[] result = new long[n];
        long[] rowSum = new long[n];
        long[] colSum = new long[n];
        long[] rowCount = new long[n];
        long[] colCount = new long[n];

        for (int i = 0; i < n; i++) {
            int x = pieces[i][0];
            int y = pieces[i][1];
            rowSum[x] += y;
            colSum[y] += x;
            rowCount[x]++;
            colCount[y]++;
        }

        for (int i = 0; i < n; i++) {
            int x = pieces[i][0];
            int y = pieces[i][1];
            result[i] = (rowSum[x] - y * rowCount[x]) + (colSum[y] - x * colCount[y]);
        }

        return result;
    }
}