import java.util.ArrayList;
import java.util.List;

class Solution {
    List<List<Integer>> adj;
    int[] informTime;

    public int numOfMinutes(int n, int headID, int[] manager, int[] informTime) {
        this.informTime = informTime;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            if (manager[i] != -1) {
                adj.get(manager[i]).add(i);
            }
        }

        return dfs(headID, 0);
    }

    private int dfs(int employeeId, int currentPathTime) {
        if (adj.get(employeeId).isEmpty()) {
            return currentPathTime;
        }

        int maxTimeFromSubordinates = 0;
        for (int subordinate : adj.get(employeeId)) {
            maxTimeFromSubordinates = Math.max(maxTimeFromSubordinates, dfs(subordinate, currentPathTime + informTime[employeeId]));
        }
        return maxTimeFromSubordinates;
    }
}