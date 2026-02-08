public class Solution {

import java.util.*;

public class Solution {
    public int maxStudents(int[][] seats) {
        int rows = seats.length;
        int cols = seats[0].length;
        int result = 0;

        for (int row = 0; row < rows; row++) {
            int[] rowSeats = new int[cols];
            for (int col = 0; col < cols; col++) {
                rowSeats[col] = seats[row][col];
            }
            result += maxStudentsInRow(rowSeats);
        }

        return result;
    }

    private int maxStudentsInRow(int[] row) {
        int n = row.length;
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            if (row[i - 1] == 0) {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = Math.max(dp[i - 1], dp[i - 2] + 1);
            }
        }
        return dp[n];
    }
}
}