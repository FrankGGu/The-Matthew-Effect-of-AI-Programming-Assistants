class Solution {
    private int[] res;
    private int[] count;
    private List<Set<Integer>> tree;

    public int[] sumOfDistancesInTree(int n, int[][] edges) {
        tree = new ArrayList<>();
        res = new int[n];
        count = new int[n];
        Arrays.fill(count, 1);

        for (int i = 0; i < n; i++) {
            tree.add(new HashSet<>());
        }
        for (int[] edge : edges) {
            tree.get(edge[0]).add(edge[1]);
            tree.get(edge[1]).add(edge[0]);
        }

        postOrder(0, -1);
        preOrder(0, -1, n);
        return res;
    }

    private void postOrder(int node, int parent) {
        for (int child : tree.get(node)) {
            if (child != parent) {
                postOrder(child, node);
                count[node] += count[child];
                res[node] += res[child] + count[child];
            }
        }
    }

    private void preOrder(int node, int parent, int n) {
        for (int child : tree.get(node)) {
            if (child != parent) {
                res[child] = res[node] - count[child] + n - count[child];
                preOrder(child, node, n);
            }
        }
    }
}