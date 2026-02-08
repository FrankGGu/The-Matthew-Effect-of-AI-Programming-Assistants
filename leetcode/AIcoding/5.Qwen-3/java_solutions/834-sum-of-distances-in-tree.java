public class Solution {

import java.util.*;

public class Solution {
    public int[] sumOfDistancesInTree(int n, int[][] edges) {
        List<Integer>[] tree = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            tree[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            tree[edge[0]].add(edge[1]);
            tree[edge[1]].add(edge[0]);
        }

        int[] res = new int[n];
        int[] count = new int[n];

        Arrays.fill(count, 1);

        dfs(0, -1, tree, count, res);
        dfs2(0, -1, tree, count, res);

        return res;
    }

    private void dfs(int node, int parent, List<Integer>[] tree, int[] count, int[] res) {
        for (int child : tree[node]) {
            if (child != parent) {
                dfs(child, node, tree, count, res);
                count[node] += count[child];
                res[node] += res[child] + count[child];
            }
        }
    }

    private void dfs2(int node, int parent, List<Integer>[] tree, int[] count, int[] res) {
        for (int child : tree[node]) {
            if (child != parent) {
                res[child] = res[node] - count[child] + (n - count[child]);
                dfs2(child, node, tree, count, res);
            }
        }
    }
}
}