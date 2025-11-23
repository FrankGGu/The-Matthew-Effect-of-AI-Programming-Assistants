public class Solution {

import java.util.*;

public class Solution {
    public List<Boolean> answerQueries(int numCourses, int[][] prerequisites, int[] queries) {
        List<Boolean> result = new ArrayList<>();
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        int[] inDegree = new int[numCourses];

        for (int i = 0; i < numCourses; i++) {
            graph.put(i, new HashSet<>());
        }

        for (int[] pre : prerequisites) {
            int course = pre[0];
            int prerequisite = pre[1];
            if (!graph.get(prerequisite).contains(course)) {
                graph.get(prerequisite).add(course);
                inDegree[course]++;
            }
        }

        for (int query : queries) {
            int course = query;
            boolean canTake = true;
            int[] tempInDegree = Arrays.copyOf(inDegree, numCourses);
            Queue<Integer> queue = new LinkedList<>();

            for (int i = 0; i < numCourses; i++) {
                if (tempInDegree[i] == 0) {
                    queue.add(i);
                }
            }

            int count = 0;

            while (!queue.isEmpty()) {
                int current = queue.poll();
                count++;

                for (int neighbor : graph.get(current)) {
                    tempInDegree[neighbor]--;
                    if (tempInDegree[neighbor] == 0) {
                        queue.add(neighbor);
                    }
                }
            }

            if (count == numCourses) {
                result.add(true);
            } else {
                result.add(false);
            }
        }

        return result;
    }
}
}