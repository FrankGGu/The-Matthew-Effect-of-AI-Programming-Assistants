public class Solution {
    public int maxJumps(int[] arr, int d, int k) {
        int n = arr.length;
        int[] dp = new int[n];
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            dfs(i, arr, d, k, dp, visited);
        }

        return dp[0];
    }

    private int dfs(int i, int[] arr, int d, int k, int[] dp, boolean[] visited) {
        if (visited[i]) {
            return dp[i];
        }

        int max = 0;
        for (int j = i + 1; j <= Math.min(i + d, arr.length - 1); j++) {
            if (arr[j] < arr[i]) {
                max = Math.max(max, dfs(j, arr, d, k, dp, visited));
            } else {
                break;
            }
        }

        for (int j = i - 1; j >= Math.max(i - d, 0); j--) {
            if (arr[j] < arr[i]) {
                max = Math.max(max, dfs(j, arr, d, k, dp, visited));
            } else {
                break;
            }
        }

        dp[i] = max + 1;
        visited[i] = true;
        return dp[i];
    }
}