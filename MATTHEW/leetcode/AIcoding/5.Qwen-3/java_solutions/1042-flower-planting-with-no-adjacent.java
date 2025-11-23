public class Solution {

import java.util.*;

public class Solution {
    public int[] gardenNoAdj(int n, int[][] paths) {
        List<Integer>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] path : paths) {
            int u = path[0] - 1;
            int v = path[1] - 1;
            graph[u].add(v);
            graph[v].add(u);
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            Set<Integer> used = new HashSet<>();
            for (int neighbor : graph[i]) {
                if (result[neighbor] != 0) {
                    used.add(result[neighbor]);
                }
            }
            for (int j = 1; j <= 4; j++) {
                if (!used.contains(j)) {
                    result[i] = j;
                    break;
                }
            }
        }
        return result;
    }
}
}