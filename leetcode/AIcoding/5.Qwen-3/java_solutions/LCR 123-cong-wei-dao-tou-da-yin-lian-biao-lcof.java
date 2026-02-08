public class Solution {
    public int booksArrange(int[] books) {
        int n = books.length;
        int[] dp = new int[n];
        dp[0] = 0;
        for (int i = 1; i < n; i++) {
            dp[i] = dp[i - 1] + Math.abs(books[i] - books[i - 1]);
        }
        return dp[n - 1];
    }
}