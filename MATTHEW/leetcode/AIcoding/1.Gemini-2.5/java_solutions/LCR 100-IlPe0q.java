import java.util.List;
import java.util.ArrayList;
import java.lang.Math;

class Solution {
    public int minimumTotal(List<List<Integer>> triangle) {
        int n = triangle.size();
        if (n == 0) {
            return 0;
        }

        // Initialize dp array with the last row of the triangle
        int[] dp = new int[n];
        List<Integer> lastRow = triangle.get(n - 1);
        for (int j = 0; j < n; j++) {
            dp[j] = lastRow.get(j);
        }

        // Iterate from the second to last row up to the first row
        for (int i = n - 2; i >= 0; i--) {
            List<Integer> currentRow = triangle.get(i);
            // For each element in the current row
            for (int j = 0; j <= i; j++) {
                // The minimum path sum from this element downwards is its value
                // plus the minimum of the two adjacent elements in the dp array (which represent
                // the minimum path sums from the row below)
                dp[j] = currentRow.get(j) + Math.min(dp[j], dp[j + 1]);
            }
        }

        // The minimum total path sum will be at dp[0] after processing all rows
        return dp[0];
    }
}