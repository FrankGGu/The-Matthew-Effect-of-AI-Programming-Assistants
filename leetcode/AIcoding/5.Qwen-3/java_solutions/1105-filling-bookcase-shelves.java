public class Solution {
    public int minHeightShelves(int[][] books, int shelfWidth) {
        int n = books.length;
        int[] dp = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            int maxHeight = 0;
            dp[i] = Integer.MAX_VALUE;
            for (int j = i - 1; j >= 0 && (maxHeight + books[j][1] <= shelfWidth); j--) {
                maxHeight = Math.max(maxHeight, books[j][1]);
                dp[i] = Math.min(dp[i], dp[j] + maxHeight);
            }
        }

        return dp[n];
    }
}