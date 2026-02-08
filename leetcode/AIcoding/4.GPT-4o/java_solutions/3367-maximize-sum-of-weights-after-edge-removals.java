import java.util.*;

public class Solution {
    public long maximizeSum(int[] nums, int[][] edges) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        long totalSum = 0;
        for (int num : nums) totalSum += num;

        long maxWeight = 0;
        boolean[] visited = new boolean[nums.length];
        for (int i = 0; i < nums.length; i++) {
            if (!visited[i]) {
                long componentSum = dfs(i, graph, nums, visited);
                maxWeight = Math.max(maxWeight, componentSum);
            }
        }

        return totalSum - maxWeight;
    }

    private long dfs(int node, Map<Integer, List<Integer>> graph, int[] nums, boolean[] visited) {
        visited[node] = true;
        long sum = nums[node];
        for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
            if (!visited[neighbor]) {
                sum += dfs(neighbor, graph, nums, visited);
            }
        }
        return sum;
    }
}