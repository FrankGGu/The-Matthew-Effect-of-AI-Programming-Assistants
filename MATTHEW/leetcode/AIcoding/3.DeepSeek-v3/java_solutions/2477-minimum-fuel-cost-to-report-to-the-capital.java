import java.util.*;

class Solution {
    private long fuel = 0;

    public long minimumFuelCost(int[][] roads, int seats) {
        int n = roads.length + 1;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            adj.get(road[0]).add(road[1]);
            adj.get(road[1]).add(road[0]);
        }
        dfs(0, -1, adj, seats);
        return fuel;
    }

    private int dfs(int node, int parent, List<List<Integer>> adj, int seats) {
        int people = 1;
        for (int child : adj.get(node)) {
            if (child != parent) {
                people += dfs(child, node, adj, seats);
            }
        }
        if (node != 0) {
            fuel += (people + seats - 1) / seats;
        }
        return people;
    }
}