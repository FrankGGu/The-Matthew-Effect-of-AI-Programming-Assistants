import java.util.Arrays;

class Solution {
    public int inventoryManagement(int[] stock, int[] warehouse) {
        Arrays.sort(stock);
        Arrays.sort(warehouse);

        int n = stock.length;
        int m = warehouse.length;

        int[][] dp = new int[n + 1][m + 1];

        // Base cases:
        // If one array is empty, the cost is to remove all items from the other array.
        for (int i = 0; i <= n; i++) {
            dp[i][0] = i; // Cost to remove i items from stock
        }
        for (int j = 0; j <= m; j++) {
            dp[0][j] = j; // Cost to remove j items from warehouse
        }

        // Fill the DP table
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                int costMatch;
                if (stock[i - 1] == warehouse[j - 1]) {
                    // If items are the same, they can stay in their respective places with no cost.
                    costMatch = 0;
                } else {
                    // If items are different, they cannot be "matched" without cost.
                    // The minimal cost to resolve this pair is to remove both items, costing 2.
                    // This implicitly covers scenarios like moving one and removing the other,
                    // or removing both and adding new ones, which would also cost at least 2.
                    costMatch = 2;
                }

                dp[i][j] = Math.min(
                    dp[i - 1][j] + 1, // Remove stock[i-1]
                    dp[i][j - 1] + 1  // Remove warehouse[j-1]
                );
                dp[i][j] = Math.min(
                    dp[i][j],
                    dp[i - 1][j - 1] + costMatch // Consider matching/replacing stock[i-1] and warehouse[j-1]
                );
            }
        }

        return dp[n][m];
    }
}