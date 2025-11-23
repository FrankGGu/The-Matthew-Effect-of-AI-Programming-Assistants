import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int numberOfGoodPaths(int[] vals, int[][] edges) {
        int n = vals.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (a, b) -> vals[a] - vals[b]);

        int[] parent = new int[n];
        int[] count = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            count[i] = 1;
        }

        int ans = n;

        for (int i = 0; i < n; i++) {
            int u = indices[i];
            for (int v : adj.get(u)) {
                if (vals[v] <= vals[u]) {
                    int rootU = find(parent, u);
                    int rootV = find(parent, v);
                    if (rootU != rootV) {
                        if (vals[findRootVal(parent, vals, rootU)] == vals[findRootVal(parent, vals, rootV)]) {
                            ans += count[rootU] * count[rootV];
                        }
                        parent[rootU] = rootV;
                        count[rootV] += count[rootU];
                    }
                }
            }
        }

        return ans;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private int findRootVal(int[] parent, int[] vals, int i) {
        int root = find(parent, i);
        return vals[root];
    }
}