public class Solution {

import java.util.*;

public class Solution {
    public int maxGroups(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] color = new int[n];
        Arrays.fill(color, -1);

        int result = 0;
        for (int i = 0; i < n; i++) {
            if (color[i] == -1) {
                Queue<Integer> queue = new LinkedList<>();
                queue.add(i);
                color[i] = 0;
                int maxLevel = 0;
                while (!queue.isEmpty()) {
                    int size = queue.size();
                    for (int j = 0; j < size; j++) {
                        int node = queue.poll();
                        for (int neighbor : graph.get(node)) {
                            if (color[neighbor] == -1) {
                                color[neighbor] = color[node] + 1;
                                queue.add(neighbor);
                                maxLevel = Math.max(maxLevel, color[neighbor]);
                            }
                        }
                    }
                }
                result += maxLevel + 1;
            }
        }
        return result;
    }
}
}