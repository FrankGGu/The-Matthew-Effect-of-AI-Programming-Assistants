public class Solution {

import java.util.*;

public class Solution {
    public int countSubtreesWithMaxDistanceBetweenCities(int n, int[][] roads) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            graph.get(road[0]).add(road[1]);
            graph.get(road[1]).add(road[0]);
        }

        int[] result = new int[1];
        dfs(0, -1, graph, new int[n], result);
        return result[0];
    }

    private int dfs(int node, int parent, List<List<Integer>> graph, int[] depth, int[] result) {
        int maxDepth = 0;
        int secondMaxDepth = 0;
        for (int neighbor : graph.get(node)) {
            if (neighbor == parent) continue;
            int childDepth = dfs(neighbor, node, graph, depth, result);
            if (childDepth > maxDepth) {
                secondMaxDepth = maxDepth;
                maxDepth = childDepth;
            } else if (childDepth > secondMaxDepth) {
                secondMaxDepth = childDepth;
            }
        }
        int maxDistance = maxDepth + secondMaxDepth;
        if (maxDistance > 0) {
            result[0]++;
        }
        return maxDepth + 1;
    }
}
}