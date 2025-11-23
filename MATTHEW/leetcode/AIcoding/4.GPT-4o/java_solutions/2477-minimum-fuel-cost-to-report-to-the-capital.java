import java.util.*;

public class Solution {
    public long minimumFuelCost(int[][] roads, int seats) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= roads.length; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            graph.get(road[0]).add(road[1]);
            graph.get(road[1]).add(road[0]);
        }

        long[] result = new long[1];
        dfs(0, -1, graph, seats, result);
        return result[0];
    }

    private int dfs(int node, int parent, List<List<Integer>> graph, int seats, long[] result) {
        int people = 1;
        for (int neighbor : graph.get(node)) {
            if (neighbor == parent) continue;
            people += dfs(neighbor, node, graph, seats, result);
        }
        if (node != 0) {
            result[0] += (people + seats - 1) / seats;
        }
        return people;
    }
}