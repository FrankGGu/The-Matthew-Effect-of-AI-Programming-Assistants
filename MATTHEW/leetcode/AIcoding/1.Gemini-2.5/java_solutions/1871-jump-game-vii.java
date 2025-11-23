class Solution {
    public boolean canReach(String s, int minJump, int maxJump) {
        int n = s.length();
        boolean[] dp = new boolean[n];
        dp[0] = true; // We are initially at index 0

        int reachableCount = 0; // Number of reachable indices in the current sliding window [i - maxJump, i - minJump]

        for (int i = 1; i < n; i++) {
            // Update the sliding window for potential jump sources for index 'i'.
            // The window is [i - maxJump, i - minJump].

            // Add dp[i - minJump] to reachableCount if it's a valid index and reachable.
            if (i - minJump >= 0) {
                if (dp[i - minJump]) {
                    reachableCount++;
                }
            }

            // Remove dp[i - maxJump - 1] from reachableCount if it's a valid index and was reachable.
            // This index is now outside the left bound of the sliding window.
            if (i - maxJump - 1 >= 0) {
                if (dp[i - maxJump - 1]) {
                    reachableCount--;
                }
            }

            // If current index s[i] is '0' and there's at least one reachable index
            // within the valid jump range [i - maxJump, i - minJump], then dp[i] is true.
            if (s.charAt(i) == '0' && reachableCount > 0) {
                dp[i] = true;
            }
        }

        return dp[n - 1];
    }
}