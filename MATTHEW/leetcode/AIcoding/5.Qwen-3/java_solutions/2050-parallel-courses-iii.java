public class Solution {

import java.util.*;

public class Solution {
    public int parallelCourses(int n, int[][] dependencies) {
        List<List<Integer>> graph = new ArrayList<>();
        int[] inDegree = new int[n];

        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] dep : dependencies) {
            int u = dep[0] - 1;
            int v = dep[1] - 1;
            graph.get(u).add(v);
            inDegree[v]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.add(i);
            }
        }

        int[] time = new int[n];
        int maxTime = 0;

        while (!queue.isEmpty()) {
            int current = queue.poll();
            maxTime = Math.max(maxTime, time[current]);

            for (int neighbor : graph.get(current)) {
                time[neighbor] = Math.max(time[neighbor], time[current] + 1);
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.add(neighbor);
                }
            }
        }

        return maxTime;
    }
}
}