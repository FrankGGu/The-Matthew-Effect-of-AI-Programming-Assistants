import java.util.*;

class Solution {
    public long countPairs(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        long totalUnreachablePairs = 0;
        long nodesProcessedInPreviousComponents = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                // Start BFS to find component size
                Queue<Integer> q = new LinkedList<>();
                q.offer(i);
                visited[i] = true;
                long currentComponentSize = 0;

                while (!q.isEmpty()) {
                    int node = q.poll();
                    currentComponentSize++;

                    for (int neighbor : adj.get(node)) {
                        if (!visited[neighbor]) {
                            visited[neighbor] = true;
                            q.offer(neighbor);
                        }
                    }
                }

                // For each node in the current component, it can form an unreachable pair
                // with any node not in this component and not in any previously processed component.
                // This effectively calculates the sum of (size of current component * size of remaining unprocessed nodes).
                // This sum correctly accumulates C_i * C_j for all i < j.
                totalUnreachablePairs += currentComponentSize * (n - currentComponentSize - nodesProcessedInPreviousComponents);

                nodesProcessedInPreviousComponents += currentComponentSize;
            }
        }

        return totalUnreachablePairs;
    }
}