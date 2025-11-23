import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;
    private List<List<Integer>> adj;
    private long[] fact;
    private long[] invFact;
    private int[] size;
    private long[] dp;

    public int waysToBuildRooms(int[] prevRoom) {
        int n = prevRoom.length;

        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            if (prevRoom[i] != -1) {
                adj.get(prevRoom[i]).add(i);
            }
        }

        precomputeFactorials(n);

        size = new int[n];
        dp = new long[n];

        dfs(0);

        return (int) dp[0];
    }

    private void precomputeFactorials(int n) {
        fact = new long[n + 1];
        invFact = new long[n + 1];
        fact[0] = 1;
        invFact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }
        invFact[n] = power(fact[n], MOD - 2);
        for (int i = n - 1; i >= 1; i--) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
    }

    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    private void dfs(int u) {
        size[u] = 1;
        dp[u] = 1;

        long currentWaysForChildren = 1;
        int nodesInChildrenSubtrees = 0;

        for (int v : adj.get(u)) {
            dfs(v);
            size[u] += size[v];

            currentWaysForChildren = (currentWaysForChildren * dp[v]) % MOD;
            currentWaysForChildren = (currentWaysForChildren * invFact[size[v]]) % MOD;
            nodesInChildrenSubtrees += size[v];
        }

        dp[u] = (currentWaysForChildren * fact[nodesInChildrenSubtrees]) % MOD;
    }
}