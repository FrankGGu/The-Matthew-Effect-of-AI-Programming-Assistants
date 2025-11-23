import java.util.*;

class Solution {
    public int divideNodes(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        int[] colors = new int[n]; // 0 or 1 for bipartite check, -1 for uncolored
        Arrays.fill(colors, -1);

        int totalMaxGroups = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                // Step 1: BFS to find connected component, check bipartiteness, and find a farthest node (u1)
                Queue<Integer> qBipartite = new LinkedList<>();
                qBipartite.offer(i);
                visited[i] = true;
                colors[i] = 0; // Start coloring with 0

                int[] distFromStartNode = new int[n];
                Arrays.fill(distFromStartNode, -1);
                distFromStartNode[i] = 0;

                int u1 = i; // Node farthest from 'i' in this BFS
                int maxDistFromStartNode = 0;

                boolean isBipartite = true;
                int componentNodeCount = 0; // Count nodes in the current component

                while (!qBipartite.isEmpty()) {
                    int u = qBipartite.poll();
                    componentNodeCount++;

                    if (distFromStartNode[u] > maxDistFromStartNode) {
                        maxDistFromStartNode = distFromStartNode[u];
                        u1 = u;
                    }

                    for (int v : adj.get(u)) {
                        if (!visited[v]) {
                            visited[v] = true;
                            colors[v] = 1 - colors[u];
                            distFromStartNode[v] = distFromStartNode[u] + 1;
                            qBipartite.offer(v);
                        } else if (colors[v] == colors[u]) {
                            isBipartite = false;
                            break;
                        }
                    }
                    if (!isBipartite) {
                        break;
                    }
                }

                if (!isBipartite) {
                    return 0; // Impossible to divide if not bipartite
                }

                if (componentNodeCount == 0) { // Should not happen if !visited[i] was true
                    continue; 
                }
                if (componentNodeCount == 1) {
                    totalMaxGroups += 1; // Diameter 0, so 0+1=1 group
                    continue;
                }

                // Step 2: BFS from u1 (farthest node from 'i') to find the diameter of the component
                Queue<Integer> qDiameter = new LinkedList<>();
                qDiameter.offer(u1);
                int[] distFromU1 = new int[n];
                Arrays.fill(distFromU1, -1);
                distFromU1[u1] = 0;
                int componentDiameter = 0;

                while (!qDiameter.isEmpty()) {
                    int u = qDiameter.poll();
                    componentDiameter = Math.max(componentDiameter, distFromU1[u]);

                    for (int v : adj.get(u)) {
                        if (distFromU1[v] == -1) { // Only traverse nodes within this component
                            distFromU1[v] = distFromU1[u] + 1;
                            qDiameter.offer(v);
                        }
                    }
                }

                totalMaxGroups += (componentDiameter + 1);
            }
        }

        return totalMaxGroups;
    }
}