class Solution {
    public int maximumNodes(int n, int[] parent, int[] target) {
        List<List<Integer>> tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            tree.get(parent[i]).add(i);
        }
        int[] res = new int[n];
        dfs(0, tree, target, res);
        return res[0];
    }

    private void dfs(int node, List<List<Integer>> tree, int[] target, int[] res) {
        int sum = 0;
        for (int child : tree.get(node)) {
            dfs(child, tree, target, res);
            sum += res[child];
        }
        if (sum == target[node]) {
            res[node] = sum + 1;
        } else if (sum < target[node]) {
            res[node] = sum;
        } else {
            res[node] = target[node];
        }
    }
}