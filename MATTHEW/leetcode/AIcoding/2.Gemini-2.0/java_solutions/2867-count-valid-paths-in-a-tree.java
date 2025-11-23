import java.util.*;

class Solution {
    private static final int MOD = 1000000007;
    private int[] primes;

    public int countValidPaths(int n, int[][] edges) {
        primes = new int[]{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97};
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        long ans = 0;
        for (int i = 1; i <= n; i++) {
            if (!isPrime(i)) {
                int[] count = dfs(i, 0, adj);
                ans = (ans + count[0]) % MOD;
            }
        }
        return (int) ans;
    }

    private int[] dfs(int node, int parent, List<List<Integer>> adj) {
        int[] count = new int[]{1, 0};
        for (int neighbor : adj.get(node)) {
            if (neighbor != parent && !isPrime(neighbor)) {
                int[] nextCount = dfs(neighbor, node, adj);
                count[1] = (count[1] + nextCount[0]) % MOD;
                count[1] = (count[1] + nextCount[1]) % MOD;
                count[0] = (count[0] + nextCount[0]) % MOD;
            }
        }
        count[1] = (count[1] + count[0]) % MOD;
        return count;
    }

    private boolean isPrime(int num) {
        for (int prime : primes) {
            if (prime == num) {
                return true;
            }
        }
        return false;
    }
}