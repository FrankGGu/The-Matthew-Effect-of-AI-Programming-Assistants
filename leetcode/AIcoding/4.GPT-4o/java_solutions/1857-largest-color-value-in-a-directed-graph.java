import java.util.*;

public class Solution {
    public int largestPathValue(String colors, int[][] edges) {
        int n = colors.length();
        int[][] graph = new int[n][n];
        int[] indegree = new int[n];
        Map<Integer, int[]> colorCount = new HashMap<>();

        for (int[] edge : edges) {
            graph[edge[0]][edge[1]] = 1;
            indegree[edge[1]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
                colorCount.put(i, new int[26]);
                colorCount.get(i)[colors.charAt(i) - 'a']++;
            }
        }

        int visited = 0;
        int maxColorValue = 0;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            visited++;
            maxColorValue = Math.max(maxColorValue, colorCount.get(node)[colors.charAt(node) - 'a']);

            for (int neighbor = 0; neighbor < n; neighbor++) {
                if (graph[node][neighbor] == 1) {
                    indegree[neighbor]--;
                    if (indegree[neighbor] == 0) {
                        queue.offer(neighbor);
                        colorCount.put(neighbor, Arrays.copyOf(colorCount.get(node), 26));
                        colorCount.get(neighbor)[colors.charAt(neighbor) - 'a']++;
                    }
                }
            }
        }

        return visited == n ? maxColorValue : -1;
    }
}