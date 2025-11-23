class Solution {
    private int[] dp;
    private int[] arr;
    private int d;
    private int n;

    public int maxJumps(int[] arr, int d) {
        this.arr = arr;
        this.d = d;
        this.n = arr.length;
        this.dp = new int[n];

        int overallMaxJumps = 0;
        for (int i = 0; i < n; i++) {
            overallMaxJumps = Math.max(overallMaxJumps, dfs(i));
        }

        return overallMaxJumps;
    }

    private int dfs(int i) {
        if (dp[i] != 0) {
            return dp[i];
        }

        int maxJumpsFromI = 1;

        // Jump to the right
        for (int j = i + 1; j <= Math.min(n - 1, i + d); j++) {
            if (arr[j] >= arr[i]) {
                break;
            }
            maxJumpsFromI = Math.max(maxJumpsFromI, 1 + dfs(j));
        }

        // Jump to the left
        for (int j = i - 1; j >= Math.max(0, i - d); j--) {
            if (arr[j] >= arr[i]) {
                break;
            }
            maxJumpsFromI = Math.max(maxJumpsFromI, 1 + dfs(j));
        }

        dp[i] = maxJumpsFromI;
        return maxJumpsFromI;
    }
}