public class Solution {

import java.util.*;

public class Solution {
    public int[] countPairsOfConnectableServers(String[] tree, int[][] edges) {
        int n = tree.length;
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];
            graph.putIfAbsent(u, new ArrayList<>());
            graph.get(u).add(new int[]{v, w});
            graph.putIfAbsent(v, new ArrayList<>());
            graph.get(v).add(new int[]{u, w});
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int serverId = i;
            int total = 0;
            int[] counts = new int[1001]; // since weights are up to 1000
            dfs(serverId, -1, 0, graph, counts);
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    int weight = Integer.parseInt(tree[j]);
                    total += counts[weight];
                }
            }
            result[i] = total;
        }
        return result;
    }

    private void dfs(int node, int parent, int currentWeight, Map<Integer, List<int[]>> graph, int[] counts) {
        counts[currentWeight]++;
        for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
            int nextNode = neighbor[0];
            int weight = neighbor[1];
            if (nextNode != parent) {
                dfs(nextNode, node, currentWeight + weight, graph, counts);
            }
        }
    }
}
}