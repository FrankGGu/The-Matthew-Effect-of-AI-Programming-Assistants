import java.util.*;

class Solution {
    public int reachableNodes(int[][] edges, int maxMoves, int n) {
        // Adjacency list to represent the graph.
        // Each entry adj.get(u) contains a list of int[] where int[0] is the neighbor node v
        // and int[1] is the count of subdivided nodes (cnt) on the edge (u, v).
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int cnt = edge[2];
            adj.get(u).add(new int[]{v, cnt});
            adj.get(v).add(new int[]{u, cnt});
        }

        // dist[i] will store the minimum moves required to reach original node i from node 0.
        // Initialize with Long.MAX_VALUE (infinity) and dist[0] = 0.
        long[] dist = new long[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[0] = 0;

        // PriorityQueue for Dijkstra's algorithm.
        // Stores elements as {moves, node}, ordered by moves.
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[0], b[0]));
        pq.offer(new long[]{0, 0}); // Start at node 0 with 0 moves.

        // Dijkstra's Algorithm
        while (!pq.isEmpty()) {
            long[] current = pq.poll();
            long currentMoves = current[0];
            int u = (int) current[1];

            // If we've already found a shorter path to 'u', skip this entry.
            if (currentMoves > dist[u]) {
                continue;
            }

            // Explore neighbors of 'u'.
            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                int cnt = neighbor[1]; // Number of subdivided nodes between u and v.

                // The cost to traverse the entire segment from u to v (or v to u) is cnt + 1.
                long newMoves = currentMoves + cnt + 1;

                // If this path is shorter than the current shortest path to 'v', update dist[v]
                // and add 'v' to the priority queue.
                if (newMoves < dist[v]) {
                    dist[v] = newMoves;
                    pq.offer(new long[]{newMoves, v});
                }
            }
        }

        // Calculate the total number of reachable nodes.
        long totalReachableNodes = 0;

        // 1. Count reachable original nodes.
        // An original node 'i' is reachable if the minimum moves to reach it (dist[i])
        // is less than or equal to maxMoves.
        for (int i = 0; i < n; i++) {
            if (dist[i] <= maxMoves) {
                totalReachableNodes++;
            }
        }

        // 2. Count reachable subdivided nodes.
        // Iterate through each original edge to count subdivided nodes.
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int cnt = edge[2]; // Total subdivided nodes on this edge.

            // Calculate how many subdivided nodes can be reached from 'u' towards 'v'.
            long reachableFromU = 0;
            if (dist[u] <= maxMoves) {
                // maxMoves - dist[u] is the remaining moves from node 'u'.
                // We can reach min(cnt, remaining_moves) subdivided nodes.
                // Math.max(0L, ...) handles cases where remaining_moves is negative.
                reachableFromU = Math.min((long)cnt, Math.max(0L, (long)maxMoves - dist[u]));
            }

            // Calculate how many subdivided nodes can be reached from 'v' towards 'u'.
            long reachableFromV = 0;
            if (dist[v] <= maxMoves) {
                reachableFromV = Math.min((long)cnt, Math.max(0L, (long)maxMoves - dist[v]));
            }

            // The total unique subdivided nodes reachable on this edge is the sum of
            // nodes reachable from 'u' and 'v', capped by the total number of
            // subdivided nodes 'cnt' on this edge.
            totalReachableNodes += Math.min((long)cnt, reachableFromU + reachableFromV);
        }

        // The problem asks for an int return type, so cast the long result.
        return (int) totalReachableNodes;
    }
}