import java.util.*;

public class Solution {
    public int maximumPathQuality(int[] values, int[][] edges, int maxTime) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        int n = values.length;
        boolean[] visited = new boolean[n];
        visited[0] = true;
        return dfs(graph, values, visited, 0, 0, maxTime, values[0]);
    }

    private int dfs(Map<Integer, List<int[]>> graph, int[] values, boolean[] visited,
                    int current, int currentTime, int maxTime, int currentQuality) {
        if (currentTime > maxTime) return 0;
        int maxQuality = currentQuality;
        for (int[] neighbor : graph.get(current)) {
            int nextNode = neighbor[0], travelTime = neighbor[1];
            boolean wasVisited = visited[nextNode];
            if (!wasVisited) {
                visited[nextNode] = true;
                maxQuality = Math.max(maxQuality, dfs(graph, values, visited, nextNode, currentTime + travelTime, maxTime, currentQuality + values[nextNode]));
                visited[nextNode] = false;
            } else {
                maxQuality = Math.max(maxQuality, dfs(graph, values, visited, nextNode, currentTime + travelTime, maxTime, currentQuality));
            }
        }
        return maxQuality;
    }
}