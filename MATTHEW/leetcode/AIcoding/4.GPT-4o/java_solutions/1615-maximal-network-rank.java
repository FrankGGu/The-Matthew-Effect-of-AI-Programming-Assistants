import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int maximalNetworkRank(int n, int[][] roads) {
        Map<Integer, Integer> degree = new HashMap<>();
        boolean[][] connected = new boolean[n][n];

        for (int[] road : roads) {
            degree.put(road[0], degree.getOrDefault(road[0], 0) + 1);
            degree.put(road[1], degree.getOrDefault(road[1], 0) + 1);
            connected[road[0]][road[1]] = true;
            connected[road[1]][road[0]] = true;
        }

        int maxRank = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int rank = degree.getOrDefault(i, 0) + degree.getOrDefault(j, 0);
                if (connected[i][j]) {
                    rank--;
                }
                maxRank = Math.max(maxRank, rank);
            }
        }

        return maxRank;
    }
}