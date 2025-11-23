import java.util.*;

class Solution {
    List<Integer>[] adj;
    boolean[] isPrime;
    boolean[] visitedPrimeNode;

    public long countPaths(int n, int[][] edges) {
        adj = new ArrayList[n + 1];
        for (int i = 1; i <= n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            adj[edge[0]].add(edge[1]);
            adj[edge[1]].add(edge[0]);
        }

        sieve(n);

        visitedPrimeNode = new boolean[n + 1];
        long totalValidPaths = 0;

        for (int i = 1; i <= n; i++) {
            if (isPrime[i] && !visitedPrimeNode[i]) {
                int componentSize = dfsCountPrimeComponent(i);
                totalValidPaths += (long) componentSize * (componentSize + 1) / 2;
            }
        }

        return totalValidPaths;
    }

    private int dfsCountPrimeComponent(int u) {
        visitedPrimeNode[u] = true;
        int count = 1;

        for (int v : adj[u]) {
            if (isPrime[v] && !visitedPrimeNode[v]) {
                count += dfsCountPrimeComponent(v);
            }
        }
        return count;
    }

    private void sieve(int n) {
        isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        if (n >= 0) isPrime[0] = false;
        if (n >= 1) isPrime[1] = false;

        for (int p = 2; p * p <= n; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= n; i += p)
                    isPrime[i] = false;
            }
        }
    }
}