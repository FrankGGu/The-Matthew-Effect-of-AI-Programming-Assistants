class Solution {
    public int maxJumps(int[] arr, int d) {
        int n = arr.length;
        int[] dp = new int[n];
        Arrays.fill(dp, -1);
        int res = 0;
        for (int i = 0; i < n; i++) {
            res = Math.max(res, dfs(arr, d, i, dp));
        }
        return res;
    }

    private int dfs(int[] arr, int d, int index, int[] dp) {
        if (dp[index] != -1) {
            return dp[index];
        }
        int res = 1;
        for (int i = index + 1; i <= Math.min(index + d, arr.length - 1) && arr[i] < arr[index]; i++) {
            res = Math.max(res, 1 + dfs(arr, d, i, dp));
        }
        for (int i = index - 1; i >= Math.max(index - d, 0) && arr[i] < arr[index]; i--) {
            res = Math.max(res, 1 + dfs(arr, d, i, dp));
        }
        dp[index] = res;
        return res;
    }
}