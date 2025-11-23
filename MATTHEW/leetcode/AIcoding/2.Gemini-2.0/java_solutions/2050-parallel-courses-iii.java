import java.util.*;

class Solution {
    public int minimumTime(int n, int[][] relations, int[] time) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        int[] indegree = new int[n];
        for (int[] relation : relations) {
            int prevCourse = relation[0] - 1;
            int nextCourse = relation[1] - 1;
            adj.get(prevCourse).add(nextCourse);
            indegree[nextCourse]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        int[] completionTime = new int[n];
        for (int i = 0; i < n; i++) {
            completionTime[i] = time[i];
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }

        while (!queue.isEmpty()) {
            int course = queue.poll();
            for (int nextCourse : adj.get(course)) {
                completionTime[nextCourse] = Math.max(completionTime[nextCourse], completionTime[course] + time[nextCourse]);
                indegree[nextCourse]--;
                if (indegree[nextCourse] == 0) {
                    queue.offer(nextCourse);
                }
            }
        }

        int maxTime = 0;
        for (int i = 0; i < n; i++) {
            maxTime = Math.max(maxTime, completionTime[i]);
        }

        return maxTime;
    }
}