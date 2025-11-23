public class Solution {

import java.util.*;

public class Solution {
    public int maximalNetworkRank(int n, int[][] roads) {
        int[] degree = new int[n];
        Set<String> roadSet = new HashSet<>();

        for (int[] road : roads) {
            int u = road[0];
            int v = road[1];
            degree[u]++;
            degree[v]++;
            roadSet.add(Math.min(u, v) + "," + Math.max(u, v));
        }

        int maxRank = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (roadSet.contains(Math.min(i, j) + "," + Math.max(i, j))) {
                    maxRank = Math.max(maxRank, degree[i] + degree[j]);
                }
            }
        }

        return maxRank;
    }
}
}