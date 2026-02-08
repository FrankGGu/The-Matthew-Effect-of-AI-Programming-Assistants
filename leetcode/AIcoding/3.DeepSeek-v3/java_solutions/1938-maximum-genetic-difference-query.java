class Solution {
    private static final int MAX_BITS = 18;
    private TrieNode root;

    class TrieNode {
        TrieNode[] children;
        int count;

        public TrieNode() {
            children = new TrieNode[2];
            count = 0;
        }
    }

    private void insert(int num) {
        TrieNode node = root;
        for (int i = MAX_BITS; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (node.children[bit] == null) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
            node.count++;
        }
    }

    private void remove(int num) {
        TrieNode node = root;
        for (int i = MAX_BITS; i >= 0; i--) {
            int bit = (num >> i) & 1;
            node = node.children[bit];
            node.count--;
        }
    }

    private int query(int num) {
        TrieNode node = root;
        int res = 0;
        for (int i = MAX_BITS; i >= 0; i--) {
            int bit = (num >> i) & 1;
            int desiredBit = 1 - bit;
            if (node.children[desiredBit] != null && node.children[desiredBit].count > 0) {
                res |= (1 << i);
                node = node.children[desiredBit];
            } else {
                node = node.children[bit];
            }
        }
        return res;
    }

    public int[] maxGeneticDifference(int[] parents, int[][] queries) {
        int n = parents.length;
        int m = queries.length;
        int[] res = new int[m];
        root = new TrieNode();

        Map<Integer, List<Integer>> tree = new HashMap<>();
        int rootNode = -1;
        for (int i = 0; i < n; i++) {
            if (parents[i] == -1) {
                rootNode = i;
            } else {
                tree.computeIfAbsent(parents[i], k -> new ArrayList<>()).add(i);
            }
        }

        Map<Integer, List<int[]>> queryMap = new HashMap<>();
        for (int i = 0; i < m; i++) {
            int node = queries[i][0];
            int val = queries[i][1];
            queryMap.computeIfAbsent(node, k -> new ArrayList<>()).add(new int[]{val, i});
        }

        dfs(rootNode, tree, queryMap, res);

        return res;
    }

    private void dfs(int node, Map<Integer, List<Integer>> tree, Map<Integer, List<int[]>> queryMap, int[] res) {
        insert(node);
        if (queryMap.containsKey(node)) {
            for (int[] query : queryMap.get(node)) {
                int val = query[0];
                int idx = query[1];
                res[idx] = query(val);
            }
        }
        if (tree.containsKey(node)) {
            for (int child : tree.get(node)) {
                dfs(child, tree, queryMap, res);
            }
        }
        remove(node);
    }
}