public class Solution {

import java.util.*;

public class Solution {
    public int[] getMinReverseOperations(int n, int[] seats) {
        int[] result = new int[seats.length];
        List<List<Integer>> graph = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    graph.get(i).add(j);
                }
            }
        }

        for (int i = 0; i < seats.length; i++) {
            int start = seats[i];
            boolean[] visited = new boolean[n];
            Queue<int[]> queue = new LinkedList<>();
            queue.add(new int[]{start, 0});
            visited[start] = true;
            int minOps = -1;

            while (!queue.isEmpty()) {
                int[] current = queue.poll();
                int pos = current[0];
                int ops = current[1];

                if (pos == 0) {
                    minOps = ops;
                    break;
                }

                for (int neighbor : graph.get(pos)) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        queue.add(new int[]{neighbor, ops + 1});
                    }
                }
            }

            result[i] = minOps;
        }

        return result;
    }
}
}