public class Solution {

import java.util.*;

public class Solution {
    public int[] cycleLengthQueries(int n, int[][] queries) {
        int[] result = new int[queries.length];
        Map<Integer, Integer> parent = new HashMap<>();
        Map<Integer, Integer> depth = new HashMap<>();

        for (int i = 1; i <= n; i++) {
            parent.put(i, i);
            depth.put(i, 0);
        }

        for (int i = 1; i <= n; i++) {
            int u = i;
            int v = i << 1;
            if (v <= n) {
                parent.put(v, u);
                depth.put(v, depth.get(u) + 1);
            }
            v = i << 1 | 1;
            if (v <= n) {
                parent.put(v, u);
                depth.put(v, depth.get(u) + 1);
            }
        }

        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            int lca = findLCA(u, v, parent, depth);
            int distance = depth.get(u) + depth.get(v) - 2 * depth.get(lca);
            result[i] = distance + 1;
        }

        return result;
    }

    private int findLCA(int u, int v, Map<Integer, Integer> parent, Map<Integer, Integer> depth) {
        while (u != v) {
            if (depth.get(u) > depth.get(v)) {
                u = parent.get(u);
            } else {
                v = parent.get(v);
            }
        }
        return u;
    }
}
}