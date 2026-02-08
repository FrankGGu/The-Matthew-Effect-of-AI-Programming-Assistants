public class Solution {

import java.util.*;

public class Solution {
    private static final int MOD = 1000000007;
    private List<Integer>[] graph;
    private long[] fact;
    private long[] invFact;

    public int waysToBuildRooms(int n, int[] parent) {
        graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int i = 1; i < n; i++) {
            graph[parent[i]].add(i);
        }

        // Precompute factorial and inverse factorial modulo MOD
        fact = new long[n + 1];
        invFact = new long[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = fact[i - 1] * i % MOD;
        }
        invFact[n] = pow(fact[n], MOD - 2);
        for (int i = n - 1; i >= 0; i--) {
            invFact[i] = invFact[i + 1] * (i + 1) % MOD;
        }

        return (int) dfs(0)[0];
    }

    private long[] dfs(int node) {
        long totalWays = 1;
        long size = 1;
        for (int child : graph[node]) {
            long[] res = dfs(child);
            totalWays = totalWays * res[0] % MOD;
            totalWays = totalWays * comb(size, res[1]) % MOD;
            size += res[1];
        }
        return new long[]{totalWays, size};
    }

    private long comb(long a, long b) {
        if (b == 0 || a == b) return 1;
        return fact[(int) a] * invFact[(int) b] % MOD * invFact[(int) (a - b)] % MOD;
    }

    private long pow(long base, long exponent) {
        long result = 1;
        while (exponent > 0) {
            if (exponent % 2 == 1) {
                result = result * base % MOD;
            }
            base = base * base % MOD;
            exponent /= 2;
        }
        return result;
    }
}
}