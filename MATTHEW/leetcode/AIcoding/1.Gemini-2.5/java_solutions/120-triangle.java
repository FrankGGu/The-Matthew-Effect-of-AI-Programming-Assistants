import java.util.List;
import java.util.ArrayList;

class Solution {
    public int minimumTotal(List<List<Integer>> triangle) {
        int n = triangle.size();
        if (n == 0) {
            return 0;
        }

        int[] dp = new int[n];

        // Initialize dp with the last row of the triangle
        List<Integer> lastRow = triangle.get(n - 1);
        for (int j = 0; j < n; j++) {
            dp[j] = lastRow.get(j);
        }

        // Iterate from the second to last row up to the first row
        for (int i = n - 2; i >= 0; i--) {
            List<Integer> currentRow = triangle.get(i);
            // For each element in the current row
            for (int j = 0; j <= i; j++) {
                // The minimum path sum from triangle[i][j] is its value
                // plus the minimum of the two adjacent elements in the dp array (which represent sums from the row below)
                dp[j] = currentRow.get(j) + Math.min(dp[j], dp[j + 1]);
            }
        }

        // The minimum total sum will be at dp[0] after processing all rows up to the top
        return dp[0];
    }
}