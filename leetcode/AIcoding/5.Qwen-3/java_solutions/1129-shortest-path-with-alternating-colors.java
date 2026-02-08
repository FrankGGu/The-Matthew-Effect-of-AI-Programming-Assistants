public class Solution {

import java.util.*;

public class Solution {
    public int[] shortestAlternatingColors(int n, int[][] redBlue) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : redBlue) {
            int u = edge[0];
            int v = edge[1];
            graph.get(u).add(v);
        }

        int[] red = new int[n];
        int[] blue = new int[n];
        Arrays.fill(red, Integer.MAX_VALUE);
        Arrays.fill(blue, Integer.MAX_VALUE);

        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{0, 0, 0}); // node, color (0: red, 1: blue)
        red[0] = 0;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int node = curr[0];
            int color = curr[1];
            int dist = curr[2];

            for (int neighbor : graph.get(node)) {
                if (color == 0 && blue[neighbor] > dist + 1) {
                    blue[neighbor] = dist + 1;
                    queue.add(new int[]{neighbor, 1, dist + 1});
                } else if (color == 1 && red[neighbor] > dist + 1) {
                    red[neighbor] = dist + 1;
                    queue.add(new int[]{neighbor, 0, dist + 1});
                }
            }
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = Math.min(red[i], blue[i]);
        }

        return result;
    }
}
}