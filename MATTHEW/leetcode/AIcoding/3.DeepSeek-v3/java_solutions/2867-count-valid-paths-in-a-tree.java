class Solution {
    private List<List<Integer>> tree;
    private boolean[] isPrime;
    private long res;

    public long countPaths(int n, int[][] edges) {
        tree = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            tree.get(u).add(v);
            tree.get(v).add(u);
        }

        isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        res = 0;
        dfs(1, -1);
        return res;
    }

    private Map<Integer, Integer> dfs(int node, int parent) {
        Map<Integer, Integer> count = new HashMap<>();
        if (isPrime[node]) {
            count.put(1, 1);
        } else {
            count.put(0, 1);
        }

        for (int child : tree.get(node)) {
            if (child == parent) continue;
            Map<Integer, Integer> childCount = dfs(child, node);
            for (int prime : childCount.keySet()) {
                for (int curr : count.keySet()) {
                    int sum = prime + curr;
                    if (sum >= 1) {
                        res += (long) childCount.get(prime) * count.get(curr);
                    }
                }
            }
            for (int prime : childCount.keySet()) {
                if (prime == 0) {
                    count.put(0, count.getOrDefault(0, 0) + childCount.get(0));
                } else {
                    count.put(prime + (isPrime[node] ? 0 : 1), count.getOrDefault(prime + (isPrime[node] ? 0 : 1), 0) + childCount.get(prime));
                }
            }
        }
        return count;
    }
}