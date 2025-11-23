import java.util.*;

class Solution {
    public int minNumberOfSemesters(int n, int[][] dependencies, int k) {
        int[] indegree = new int[n];
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] dependency : dependencies) {
            int u = dependency[0] - 1;
            int v = dependency[1] - 1;
            adj.get(u).add(v);
            indegree[v]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }

        int semesters = 0;
        int taken = 0;
        while (taken < n) {
            semesters++;
            int count = Math.min(k, queue.size());
            List<Integer> toRemove = new ArrayList<>();
            for (int i = 0; i < count; i++) {
                int u = queue.poll();
                taken++;
                toRemove.add(u);
            }

            for (int u : toRemove) {
                for (int v : adj.get(u)) {
                    indegree[v]--;
                    if (indegree[v] == 0) {
                        queue.offer(v);
                    }
                }
            }
        }

        return semesters;
    }
}