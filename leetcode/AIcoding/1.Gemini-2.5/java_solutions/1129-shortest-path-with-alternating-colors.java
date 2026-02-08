import java.util.*;

class Solution {
    public int[] shortestAlternatingPaths(int n, int[][] redEdges, int[][] blueEdges) {
        // adj[color][u] stores a list of neighbors v reachable from u by an edge of 'color'.
        // color 0 for red, 1 for blue.
        List<Integer>[][] adj = new List[2][n];
        for (int i = 0; i < n; i++) {
            adj[0][i] = new ArrayList<>();
            adj[1][i] = new ArrayList<>();
        }

        for (int[] edge : redEdges) {
            adj[0][edge[0]].add(edge[1]);
        }
        for (int[] edge : blueEdges) {
            adj[1][edge[0]].add(edge[1]);
        }

        // dist[node][color_of_last_edge] stores the shortest path length from node 0
        // to 'node', such that the last edge taken was of 'color_of_last_edge'.
        // color_of_last_edge: 0 for red, 1 for blue.
        int[][] dist = new int[n][2];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }

        // BFS queue: stores [node, color_of_last_edge_to_reach_node]
        Queue<int[]> q = new LinkedList<>();

        // Node 0 has a path length of 0. We can conceptually consider it reached by
        // either a red or a blue edge of length 0. This allows us to take the first
        // step from node 0 using either a blue or a red edge, respectively.
        dist[0][0] = 0; // Shortest path to 0 ending with a red edge
        dist[0][1] = 0; // Shortest path to 0 ending with a blue edge
        q.offer(new int[]{0, 0}); // Start from node 0, assuming last edge was red (so next must be blue)
        q.offer(new int[]{0, 1}); // Start from node 0, assuming last edge was blue (so next must be red)

        while (!q.isEmpty()) {
            int[] current = q.poll();
            int u = current[0];
            int lastColor = current[1]; // Color of the edge used to reach 'u'
            int currentDist = dist[u][lastColor];

            // The next edge must be of the opposite color to maintain alternation
            int nextColor = 1 - lastColor;

            // Explore neighbors reachable by 'nextColor' edges from 'u'
            for (int v : adj[nextColor][u]) {
                // If this path to 'v' (ending with 'nextColor') is shorter than previously found
                if (dist[v][nextColor] == Integer.MAX_VALUE) {
                    dist[v][nextColor] = currentDist + 1;
                    q.offer(new int[]{v, nextColor});
                }
            }
        }

        // Consolidate the results for each node.
        // The shortest path to node 'i' is the minimum of paths ending with a red edge
        // and paths ending with a blue edge.
        int[] ans = new int[n];
        for (int i = 0; i < n; i++) {
            int minPath = Math.min(dist[i][0], dist[i][1]);
            ans[i] = (minPath == Integer.MAX_VALUE) ? -1 : minPath;
        }

        return ans;
    }
}