class Solution {
    private static final int MOD = 1000000007;
    private int[] parent;
    private int[] rank;

    public int[] bonus(int n, int[][] leadership, int[][] operations) {
        parent = new int[n + 1];
        rank = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            parent[i] = i;
            rank[i] = 1;
        }

        for (int[] relation : leadership) {
            int u = relation[0];
            int v = relation[1];
            parent[v] = u;
        }

        Map<Integer, List<Integer>> tree = new HashMap<>();
        for (int i = 1; i <= n; i++) {
            int root = find(i);
            tree.computeIfAbsent(root, k -> new ArrayList<>()).add(i);
        }

        int[] coins = new int[n + 1];
        Map<Integer, Long> sumMap = new HashMap<>();
        for (int root : tree.keySet()) {
            sumMap.put(root, 0L);
        }

        List<Integer> res = new ArrayList<>();
        for (int[] op : operations) {
            if (op[0] == 1) {
                int u = op[1];
                int coin = op[2];
                coins[u] += coin;
                int root = find(u);
                sumMap.put(root, sumMap.get(root) + coin);
            } else if (op[0] == 2) {
                int u = op[1];
                int coin = op[2];
                int root = find(u);
                List<Integer> nodes = tree.get(root);
                long sum = 0;
                for (int node : nodes) {
                    if (isChild(node, u)) {
                        coins[node] += coin;
                        sum += coin;
                    }
                }
                sumMap.put(root, sumMap.get(root) + sum);
            } else {
                int u = op[1];
                int root = find(u);
                long sum = 0;
                List<Integer> nodes = tree.get(root);
                for (int node : nodes) {
                    if (isChild(node, u)) {
                        sum += coins[node];
                    }
                }
                res.add((int) (sum % MOD));
            }
        }

        int[] ans = new int[res.size()];
        for (int i = 0; i < res.size(); i++) {
            ans[i] = res.get(i);
        }
        return ans;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private boolean isChild(int node, int u) {
        while (node != u && node != parent[node]) {
            node = parent[node];
        }
        return node == u;
    }
}