import java.util.*;

class Solution {
    public List<Boolean> checkIfPrerequisite(int numCourses, int[][] prerequisites, int[][] queries) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < numCourses; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] pre : prerequisites) {
            adj.get(pre[0]).add(pre[1]);
        }

        boolean[][] reachable = new boolean[numCourses][numCourses];
        for (int i = 0; i < numCourses; i++) {
            Queue<Integer> q = new LinkedList<>();
            q.offer(i);
            boolean[] visited = new boolean[numCourses];
            visited[i] = true;
            while (!q.isEmpty()) {
                int curr = q.poll();
                for (int neighbor : adj.get(curr)) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        reachable[i][neighbor] = true;
                        q.offer(neighbor);
                    }
                }
            }
        }

        List<Boolean> result = new ArrayList<>();
        for (int[] query : queries) {
            result.add(reachable[query[0]][query[1]]);
        }
        return result;
    }
}