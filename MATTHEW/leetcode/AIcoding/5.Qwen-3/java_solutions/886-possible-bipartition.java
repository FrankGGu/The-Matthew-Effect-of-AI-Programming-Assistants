public class Solution {

import java.util.*;

public class Solution {
    public boolean possibleBipartition(int[][] dislikes) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] dislike : dislikes) {
            graph.computeIfAbsent(dislike[0], k -> new ArrayList<>()).add(dislike[1]);
            graph.computeIfAbsent(dislike[1], k -> new ArrayList<>()).add(dislike[0]);
        }

        int[] color = new int[graph.size() + 1];
        Arrays.fill(color, -1);

        for (int i = 1; i <= graph.size(); i++) {
            if (color[i] == -1 && !bfs(i, graph, color)) {
                return false;
            }
        }

        return true;
    }

    private boolean bfs(int start, Map<Integer, List<Integer>> graph, int[] color) {
        Queue<Integer> queue = new LinkedList<>();
        queue.add(start);
        color[start] = 0;

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int neighbor : graph.getOrDefault(current, new ArrayList<>())) {
                if (color[neighbor] == color[current]) {
                    return false;
                }
                if (color[neighbor] == -1) {
                    color[neighbor] = 1 - color[current];
                    queue.add(neighbor);
                }
            }
        }

        return true;
    }
}
}