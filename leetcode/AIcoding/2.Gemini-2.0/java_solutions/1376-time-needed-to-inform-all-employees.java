import java.util.*;

class Solution {
    public int numOfMinutes(int n, int headID, int[] manager, int[] informTime) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int i = 0; i < n; i++) {
            if (manager[i] != -1) {
                adj.get(manager[i]).add(i);
            }
        }

        Queue<int[]> q = new LinkedList<>();
        q.offer(new int[]{headID, 0});
        int maxTime = 0;

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int employee = curr[0];
            int time = curr[1];
            maxTime = Math.max(maxTime, time);

            for (int subordinate : adj.get(employee)) {
                q.offer(new int[]{subordinate, time + informTime[employee]});
            }
        }

        return maxTime;
    }
}