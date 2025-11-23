public class Solution {

import java.util.*;

public class Solution {
    private int[][] edges;
    private boolean[] visited;
    private int totalFuel;

    public int minimumFuelCost(int n, int[][] roads) {
        edges = new int[n][];
        for (int i = 0; i < n; i++) {
            edges[i] = new int[0];
        }
        for (int[] road : roads) {
            int u = road[0], v = road[1];
            edges[u] = Arrays.copyOf(edges[u], edges[u].length + 1);
            edges[u][edges[u].length - 1] = v;
            edges[v] = Arrays.copyOf(edges[v], edges[v].length + 1);
            edges[v][edges[v].length - 1] = u;
        }
        visited = new boolean[n];
        totalFuel = 0;
        dfs(0, -1);
        return totalFuel;
    }

    private int dfs(int node, int parent) {
        visited[node] = true;
        int cars = 1;
        for (int neighbor : edges[node]) {
            if (neighbor != parent) {
                int childCars = dfs(neighbor, node);
                cars += childCars;
                totalFuel += childCars;
            }
        }
        return cars;
    }
}
}