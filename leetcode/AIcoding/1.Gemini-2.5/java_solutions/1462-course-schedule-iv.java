import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Boolean> checkIfPrerequisite(int n, int[][] prerequisites, int[][] queries) {
        boolean[][] isReachable = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            isReachable[i][i] = true; // A course is a prerequisite for itself (or reachable from itself)
        }

        for (int[] pre : prerequisites) {
            isReachable[pre[0]][pre[1]] = true;
        }

        for (int k = 0; k < n; k++) { // Intermediate node
            for (int i = 0; i < n; i++) { // Source node
                for (int j = 0; j < n; j++) { // Destination node
                    isReachable[i][j] = isReachable[i][j] || (isReachable[i][k] && isReachable[k][j]);
                }
            }
        }

        List<Boolean> result = new ArrayList<>();
        for (int[] query : queries) {
            result.add(isReachable[query[0]][query[1]]);
        }

        return result;
    }
}