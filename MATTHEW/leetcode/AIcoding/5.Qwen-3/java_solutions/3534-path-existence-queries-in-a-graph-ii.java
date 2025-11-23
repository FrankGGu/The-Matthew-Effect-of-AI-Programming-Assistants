public class Solution {

import java.util.*;

public class Solution {
    public List<Boolean> checkIfPrerequisite(int numCourses, int[][] prerequisites, int[][] queries) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < numCourses; i++) {
            graph.add(new ArrayList<>());
        }
        int[] inDegree = new int[numCourses];
        for (int[] pre : prerequisites) {
            graph.get(pre[0]).add(pre[1]);
            inDegree[pre[1]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < numCourses; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        List<Set<Integer>> reachable = new ArrayList<>();
        for (int i = 0; i < numCourses; i++) {
            reachable.add(new HashSet<>());
        }

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int neighbor : graph.get(current)) {
                reachable.get(neighbor).add(current);
                reachable.get(neighbor).addAll(reachable.get(current));
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        List<Boolean> result = new ArrayList<>();
        for (int[] query : queries) {
            result.add(reachable.get(query[1]).contains(query[0]));
        }

        return result;
    }
}
}