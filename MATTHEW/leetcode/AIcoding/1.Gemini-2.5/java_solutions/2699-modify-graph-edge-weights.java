import java.util.*;

class Solution {
    private static final long INF = Long.MAX_VALUE;

    // Dijkstra's algorithm to find shortest paths from a startNode.
    // It takes the number of nodes, the current state of edges (which might be modified),
    // and the starting node.
    // Returns an array of shortest distances from startNode to all other nodes.
    // If a path is not found, distance is INF.
    private long[] dijkstra(int n, int[][] currentEdges, int startNode) {
        long[] dist = new long[n];
        Arrays.fill(dist, INF);
        dist[startNode] = 0;

        // Build adjacency list from currentEdges for the current Dijkstra run
        List<int[]>[] adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] edge : currentEdges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].add(new int[]{v, w});
            adj[v].add(new int[]{u, w}); // Graph is undirected
        }

        // PriorityQueue stores [distance, node]
        PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[0]));
        pq.offer(new long[]{0, startNode});

        while (!pq.isEmpty()) {
            long[] current = pq.poll();
            long d = current[0];
            int u = (int) current[1];

            if (d > dist[u]) {
                continue;
            }

            for (int[] edge : adj[u]) {
                int v = edge[0];
                int weight = edge[1];

                // Check for potential overflow before adding to dist[u]
                if (dist[u] != INF && dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.offer(new long[]{dist[v], v});
                }
            }
        }
        return dist;
    }

    public int[][] modifiedGraphEdges(int n, int[][] edges, int source, int destination, int target) {
        // Create a modifiable copy of the original edges.
        // This array will be returned if a solution is found.
        int[][] resultEdges = new int[edges.length][3];
        for (int i = 0; i < edges.length; i++) {
            resultEdges[i] = new int[]{edges[i][0], edges[i][1], edges[i][2]};
        }

        // Phase 1: Calculate the shortest path with all -1 edges temporarily set to 1.
        // This finds the minimum possible shortest path length.

        // Store indices of original -1 edges to modify them later if needed.
        List<Integer> negOneIndices = new ArrayList<>();
        for (int i = 0; i < resultEdges.length; i++) {
            if (resultEdges[i][2] == -1) {
                resultEdges[i][2] = 1; // Temporarily set -1 edges to 1
                negOneIndices.add(i);
            }
        }

        long[] distsPhase1 = dijkstra(n, resultEdges, source);

        if (distsPhase1[destination] < target) {
            // Case 1: Even with all -1 edges as 1, the shortest path is too short.
            // We need to increase the weights of some -1 edges to reach 'target'.
            long diff = target - distsPhase1[destination];

            // Greedily distribute the 'diff' among the original -1 edges.
            // We iterate through them in their original order.
            for (int idx : negOneIndices) {
                if (diff > 0) {
                    // Increase this edge's weight by up to 'diff'.
                    // The current weight is 1. We add 'increase' to it.
                    // Ensure the new weight does not exceed Integer.MAX_VALUE.
                    long increase = Math.min(diff, (long)Integer.MAX_VALUE - resultEdges[idx][2]);
                    resultEdges[idx][2] += increase;
                    diff -= increase;
                } else {
                    // If diff is 0, all remaining -1 edges stay at 1 (as they were set initially).
                    break;
                }
            }

            // After distributing the 'diff', run Dijkstra again to verify the new shortest path.
            long[] distsFinal = dijkstra(n, resultEdges, source);

            if (distsFinal[destination] == target) {
                // If the shortest path is now exactly 'target', we found a solution.
                return resultEdges;
            } else {
                // If it's not 'target' (either too long or still too short),
                // it means this greedy strategy didn't work, or the path changed,
                // and it's impossible to achieve 'target'.
                return new int[][]{};
            }

        } else if (distsPhase1[destination] == target) {
            // Case 2: The shortest path is already 'target' with all -1 edges set to 1.
            // This is a valid solution. The 'resultEdges' array already has -1 edges set to 1.
            return resultEdges;

        } else { // distsPhase1[destination] > target
            // Case 3: Even with all -1 edges set to 1 (minimum possible weights),
            // the shortest path is already longer than 'target'.
            // It's impossible to achieve 'target'.
            return new int[][]{};
        }
    }
}