import java.util.ArrayList;
import java.util.List;

class Solution {
    long totalFuelCost = 0;

    public long minimumFuelCost(int n, int[][] roads, int seats) {
        if (n == 1) {
            return 0;
        }

        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] road : roads) {
            adj.get(road[0]).add(road[1]);
            adj.get(road[1]).add(road[0]);
        }

        dfs(0, -1, adj, seats);

        return totalFuelCost;
    }

    private long dfs(int u, int parent, List<List<Integer>> adj, int seats) {
        long peopleInSubtree = 1;

        for (int v : adj.get(u)) {
            if (v == parent) {
                continue;
            }
            peopleInSubtree += dfs(v, u, adj, seats);
        }

        if (u != 0) {
            long carsNeeded = (peopleInSubtree + seats - 1) / seats;
            totalFuelCost += carsNeeded;
        }

        return peopleInSubtree;
    }
}