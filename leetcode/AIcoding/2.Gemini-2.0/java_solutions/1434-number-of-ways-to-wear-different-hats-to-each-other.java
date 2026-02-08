class Solution {
    private int mod = 1000000007;
    private int[][] adj;
    private int n;
    private Integer[][] memo;

    public int numberWays(List<List<Integer>> hats) {
        n = hats.size();
        adj = new int[41][n];
        for (int i = 0; i < n; i++) {
            for (int hat : hats.get(i)) {
                adj[hat][i] = 1;
            }
        }
        memo = new Integer[41][1 << n];
        return solve(1, 0);
    }

    private int solve(int hat, int mask) {
        if (mask == (1 << n) - 1) {
            return 1;
        }
        if (hat > 40) {
            return 0;
        }
        if (memo[hat][mask] != null) {
            return memo[hat][mask];
        }

        int ans = solve(hat + 1, mask);
        for (int i = 0; i < n; i++) {
            if (adj[hat][i] == 1 && (mask & (1 << i)) == 0) {
                ans = (ans + solve(hat + 1, mask | (1 << i))) % mod;
            }
        }

        return memo[hat][mask] = ans;
    }
}