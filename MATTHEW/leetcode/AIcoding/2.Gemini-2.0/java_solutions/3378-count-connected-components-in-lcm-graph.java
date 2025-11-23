import java.util.Arrays;

class Solution {
    public int countConnectedComponents(int n, int[][] edges) {
        int[] parent = new int[n + 1];
        Arrays.setAll(parent, i -> i);

        for (int[] edge : edges) {
            union(parent, edge[0], edge[1]);
        }

        int count = 0;
        for (int i = 1; i <= n; i++) {
            if (find(parent, i) == i) {
                count++;
            }
        }

        return count;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private void union(int[] parent, int a, int b) {
        int rootA = find(parent, a);
        int rootB = find(parent, b);
        if (rootA != rootB) {
            parent[rootA] = rootB;
        }
    }
}