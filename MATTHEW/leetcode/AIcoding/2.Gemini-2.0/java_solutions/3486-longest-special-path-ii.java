import java.util.*;

class Solution {
    public int longestSpecialPath(int n, int[][] edges, int[] values) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int maxLen = 0;
        for (int start = 0; start < n; start++) {
            Queue<int[]> queue = new LinkedList<>();
            queue.offer(new int[]{start, values[start], 1});
            Set<Integer> visited = new HashSet<>();

            while (!queue.isEmpty()) {
                int[] curr = queue.poll();
                int node = curr[0];
                int pathSum = curr[1];
                int pathLen = curr[2];

                maxLen = Math.max(maxLen, pathLen);

                visited.add(node);

                for (int neighbor : adj.get(node)) {
                    if (!visited.contains(neighbor) && values[neighbor] % values[start] == 0) {
                        queue.offer(new int[]{neighbor, pathSum + values[neighbor], pathLen + 1});
                    }
                }
                visited.remove(node);
            }
        }

        return maxLen;
    }
}