class Solution {

    private static class Node {
        Node[] children = new Node[2];
        int count = 0;
    }

    public int[] maxGeneticDifference(int[] parents, int[][] queries) {
        int n = parents.length;
        int[] ans = new int[queries.length];

        List<Integer>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        int root = -1;
        for (int i = 0; i < n; i++) {
            if (parents[i] == -1) {
                root = i;
            } else {
                adj[parents[i]].add(i);
            }
        }

        List<int[]>[] queryList = new List[n];
        for (int i = 0; i < n; i++) {
            queryList[i] = new ArrayList<>();
        }

        for (int i = 0; i < queries.length; i++) {
            queryList[queries[i][0]].add(new int[]{queries[i][1], i});
        }

        Node trie = new Node();

        dfs(root, adj, queryList, trie, ans);

        return ans;
    }

    private void dfs(int node, List<Integer>[] adj, List<int[]>[] queryList, Node trie, int[] ans) {
        insert(trie, node);

        for (int[] query : queryList[node]) {
            ans[query[1]] = maxXor(trie, query[0]);
        }

        for (int child : adj[node]) {
            dfs(child, adj, queryList, trie, ans);
        }

        remove(trie, node);
    }

    private void insert(Node trie, int num) {
        Node curr = trie;
        for (int i = 17; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (curr.children[bit] == null) {
                curr.children[bit] = new Node();
            }
            curr = curr.children[bit];
            curr.count++;
        }
    }

    private void remove(Node trie, int num) {
        Node curr = trie;
        for (int i = 17; i >= 0; i--) {
            int bit = (num >> i) & 1;
            curr = curr.children[bit];
            curr.count--;
        }
    }

    private int maxXor(Node trie, int num) {
        Node curr = trie;
        int maxXor = 0;
        for (int i = 17; i >= 0; i--) {
            int bit = (num >> i) & 1;
            int oppositeBit = 1 - bit;
            if (curr.children[oppositeBit] != null && curr.children[oppositeBit].count > 0) {
                maxXor |= (1 << i);
                curr = curr.children[oppositeBit];
            } else {
                curr = curr.children[bit];
            }
        }
        return maxXor;
    }
}