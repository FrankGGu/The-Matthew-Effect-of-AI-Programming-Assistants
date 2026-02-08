public class Solution {

import java.util.*;

public class Solution {
    public boolean[] checkIfPrerequisite(int numCourses, int[][] prerequisites, int[][] queries) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < numCourses; i++) {
            graph.add(new ArrayList<>());
        }
        int[] inDegree = new int[numCourses];
        for (int[] pre : prerequisites) {
            graph.get(pre[0]).add(pre[1]);
            inDegree[pre[1]]++;
        }

        boolean[][] reachable = new boolean[numCourses][numCourses];
        Queue<Integer> queue = new LinkedList<>();

        for (int i = 0; i < numCourses; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int neighbor : graph.get(current)) {
                reachable[current][neighbor] = true;
                for (int i = 0; i < numCourses; i++) {
                    if (reachable[i][current]) {
                        reachable[i][neighbor] = true;
                    }
                }
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        boolean[] result = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            result[i] = reachable[queries[i][0]][queries[i][1]];
        }

        return result;
    }
}
}