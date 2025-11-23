import java.util.ArrayList;
import java.util.List;

class Solution {
    public long minimumFuelCost(int n, int[][] roads, int seats) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            adj.get(road[0]).add(road[1]);
            adj.get(road[1]).add(road[0]);
        }

        long[] fuel = {0};
        dfs(0, -1, adj, seats, fuel);
        return fuel[0];
    }

    private int dfs(int node, int parent, List<List<Integer>> adj, int seats, long[] fuel) {
        int people = 1;
        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                people += dfs(neighbor, node, adj, seats, fuel);
            }
        }

        if (node != 0) {
            fuel[0] += (people + seats - 1) / seats;
        }

        return people;
    }
}