import java.util.*;

class Solution {

    public int electricCarPlan(int n, int[][] paths, int[] charge, int k) {
        // Adjacency matrix to store the direct path weights between intersections.
        // Initialize with a large value (Integer.MAX_VALUE / 2) to represent no direct path
        // and prevent overflow when adding weights.
        int[][] adj = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(adj[i], Integer.MAX_VALUE / 2);
            adj[i][i] = 0; // Distance to self is 0
        }

        // Populate the adjacency matrix with given path weights.
        // Since paths are undirected, update both adj[u][v] and adj[v][u].
        for (int[] path : paths) {
            int u = path[0];
            int v = path[1];
            int w = path[2];
            adj[u][v] = Math.min(adj[u][v], w);
            adj[v][u] = Math.min(adj[v][u], w);
        }

        // dist[mask][u][battery_level] stores the minimum time to visit all intersections
        // represented by 'mask', ending at intersection 'u', with 'battery_level' remaining.
        // The maximum possible time (18*100 + 18*18*100 = 34200) fits within a 'char' (unsigned 16-bit, 0-65535).
        // Using 'char' to optimize memory usage.
        char[][][] dist = new char[1 << n][n][k + 1];
        for (int i = 0; i < (1 << n); i++) {
            for (int j = 0; j < n; j++) {
                Arrays.fill(dist[i][j], (char) 0xFFFF); // Initialize with max char value (effectively infinity)
            }
        }

        // PriorityQueue for Dijkstra's algorithm.
        // Stores elements as {time, mask, current_node, current_battery_level}.
        // Sorts by time in ascending order.
        PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[0]));

        // Initial state: Start at node 0, mask (1 << 0), full battery k, time 0.
        dist[1 << 0][0][k] = 0;
        pq.offer(new long[]{0, 1 << 0, 0, k});

        // The target mask representing all intersections visited.
        int finalMask = (1 << n) - 1;
        long minTotalTime = Long.MAX_VALUE; // Stores the minimum time found to visit all nodes.

        while (!pq.isEmpty()) {
            long[] curr = pq.poll();
            long time = curr[0];
            int mask = (int) curr[1];
            int u = (int) curr[2];
            int battery = (int) curr[3];

            // If we've found a shorter path to this state already, skip.
            if (time > dist[mask][u][battery]) {
                continue;
            }

            // If all intersections have been visited, update the minimum total time.
            if (mask == finalMask) {
                minTotalTime = Math.min(minTotalTime, time);
            }

            // Option 1: Charge at the current intersection 'u'.
            // Battery becomes full (k), time increases by charge[u].
            long newTimeAfterCharge = time + charge[u];
            // Check for potential overflow and if this path is shorter.
            if (newTimeAfterCharge <= (char) 0xFFFF && newTimeAfterCharge < dist[mask][u][k]) {
                dist[mask][u][k] = (char) newTimeAfterCharge;
                pq.offer(new long[]{newTimeAfterCharge, mask, u, k});
            }

            // Option 2: Travel from current intersection 'u' to an adjacent intersection 'v'.
            for (int v = 0; v < n; v++) {
                // Skip if u equals v, or if there's no direct path.
                if (u == v || adj[u][v] == Integer.MAX_VALUE / 2) {
                    continue;
                }

                int travelCost = adj[u][v];
                // Check if there's enough battery to make the trip.
                if (battery >= travelCost) {
                    int newBattery = battery - travelCost;
                    int newMask = mask | (1 << v); // Mark 'v' as visited.
                    long newTimeAfterTravel = time + travelCost;

                    // Check for potential overflow and if this path is shorter.
                    if (newTimeAfterTravel <= (char) 0xFFFF && newTimeAfterTravel < dist[newMask][v][newBattery]) {
                        dist[newMask][v][newBattery] = (char) newTimeAfterTravel;
                        pq.offer(new long[]{newTimeAfterTravel, newMask, v, newBattery});
                    }
                }
            }
        }

        return (int) minTotalTime;
    }
}