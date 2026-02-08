import java.util.ArrayList;
import java.util.List;

class Solution {
    private static final int MOD = (int) 1e9 + 7;
    private List<Integer>[] tree;
    private long[] fact;
    private long[] invFact;
    private long[] dp;
    private int[] size;

    public int waysToBuildRooms(int[] prevRoom) {
        int n = prevRoom.length;
        tree = new List[n];
        for (int i = 0; i < n; i++) {
            tree[i] = new ArrayList<>();
        }
        for (int i = 1; i < n; i++) {
            tree[prevRoom[i]].add(i);
        }

        fact = new long[n + 1];
        invFact = new long[n + 1];
        fact[0] = invFact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = fact[i - 1] * i % MOD;
            invFact[i] = invFact[i - 1] * pow(i, MOD - 2) % MOD;
        }

        dp = new long[n];
        size = new int[n];
        dfs(0);
        return (int) dp[0];
    }

    private void dfs(int u) {
        dp[u] = 1;
        size[u] = 1;
        for (int v : tree[u]) {
            dfs(v);
            size[u] += size[v];
            dp[u] = dp[u] * dp[v] % MOD;
            dp[u] = dp[u] * invFact[size[v]] % MOD;
        }
        dp[u] = dp[u] * fact[size[u] - 1] % MOD;
    }

    private long pow(long a, int b) {
        long res = 1;
        while (b > 0) {
            if ((b & 1) == 1) {
                res = res * a % MOD;
            }
            a = a * a % MOD;
            b >>= 1;
        }
        return res;
    }
}