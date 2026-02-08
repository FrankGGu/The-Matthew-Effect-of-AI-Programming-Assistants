class Solution {
    private static final int MOD = 1000000007;

    public int countWays(int[] predecessors) {
        int n = predecessors.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        int root = -1;
        for (int i = 0; i < n; i++) {
            if (predecessors[i] == -1) {
                root = i;
            } else {
                adj.get(predecessors[i]).add(i);
            }
        }

        long[] fact = new long[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        long[] invFact = new long[n + 1];
        invFact[n] = power(fact[n], MOD - 2);
        for (int i = n - 1; i >= 0; i--) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }

        return (int) dfs(root, adj, fact, invFact)[0];
    }

    private long[] dfs(int u, List<List<Integer>> adj, long[] fact, long[] invFact) {
        long size = 1;
        long ways = 1;

        for (int v : adj.get(u)) {
            long[] childResult = dfs(v, adj, fact, invFact);
            ways = (ways * childResult[0]) % MOD;
            size += childResult[1];
        }

        ways = (ways * combination(size - 1, size - 1 - (size - 1 - (long)adj.get(u).size()), fact, invFact)) % MOD;

        return new long[]{ways, size};
    }

    private long combination(long n, long k, long[] fact, long[] invFact) {
        if (k < 0 || k > n) {
            return 0;
        }
        return (((fact[(int) n] * invFact[(int) k]) % MOD) * invFact[(int) (n - k)]) % MOD;
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
}