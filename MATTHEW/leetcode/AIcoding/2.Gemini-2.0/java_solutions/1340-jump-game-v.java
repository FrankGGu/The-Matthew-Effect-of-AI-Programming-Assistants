class Solution {
    public int maxJumps(int[] arr, int d) {
        int n = arr.length;
        Integer[] dp = new Integer[n];
        int ans = 0;
        for (int i = 0; i < n; i++) {
            ans = Math.max(ans, dfs(arr, d, i, dp));
        }
        return ans;
    }

    private int dfs(int[] arr, int d, int i, Integer[] dp) {
        if (dp[i] != null) {
            return dp[i];
        }

        int n = arr.length;
        int max = 1;
        for (int j = i + 1; j <= Math.min(i + d, n - 1); j++) {
            if (arr[j] >= arr[i]) {
                break;
            }
            max = Math.max(max, 1 + dfs(arr, d, j, dp));
        }

        for (int j = i - 1; j >= Math.max(i - d, 0); j--) {
            if (arr[j] >= arr[i]) {
                break;
            }
            max = Math.max(max, 1 + dfs(arr, d, j, dp));
        }

        dp[i] = max;
        return max;
    }
}