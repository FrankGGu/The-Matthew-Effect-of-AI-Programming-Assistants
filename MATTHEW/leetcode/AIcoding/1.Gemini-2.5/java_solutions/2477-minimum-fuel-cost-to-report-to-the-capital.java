import java.util.ArrayList;
import java.util.List;

class Solution {
    private long totalFuel = 0;
    private int S; // seats

    public long minimumFuelCost(int[][] roads, int seats) {
        int n = roads.length + 1;
        S = seats;

        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] road : roads) {
            adj.get(road[0]).add(road[1]);
            adj.get(road[1]).add(road[0]);
        }

        // Start DFS from the capital (node 0). Its parent is -1 (null).
        dfs(0, -1, adj);

        return totalFuel;
    }

    // This DFS function returns the total number of people in the subtree rooted at 'u'
    // (including the representative at 'u' itself).
    private long dfs(int u, int p, List<List<Integer>> adj) {
        long peopleCount = 1; // Start with the representative at node 'u'

        for (int v : adj.get(u)) {
            if (v == p) {
                continue; // Avoid going back to the parent
            }

            long peopleInSubtreeV = dfs(v, u, adj);

            // Calculate the number of cars needed to transport peopleInSubtreeV from 'v' to 'u'.
            // This is a ceiling division: (a + b - 1) / b
            long carsNeeded = (peopleInSubtreeV + S - 1) / S;

            // Each car traveling from 'v' to 'u' consumes 1 liter of fuel.
            totalFuel += carsNeeded;

            // Add the people from 'v''s subtree to 'u''s people count.
            peopleCount += peopleInSubtreeV;
        }

        return peopleCount;
    }
}