public class Solution {

import java.util.*;

public class Solution {
    public int[] robotSim(int[] commands, int[][] obstacles) {
        int[] direction = {0, 1};
        int x = 0, y = 0;
        int maxDistance = 0;
        Set<String> obstacleSet = new HashSet<>();
        for (int[] obstacle : obstacles) {
            obstacleSet.add(obstacle[0] + "," + obstacle[1]);
        }
        for (int command : commands) {
            if (command == -1) {
                direction = new int[]{direction[1], -direction[0]};
            } else if (command == -2) {
                direction = new int[]{-direction[1], direction[0]};
            } else {
                for (int i = 0; i < command; i++) {
                    int nx = x + direction[0];
                    int ny = y + direction[1];
                    if (obstacleSet.contains(nx + "," + ny)) {
                        break;
                    }
                    x = nx;
                    y = ny;
                    maxDistance = Math.max(maxDistance, x * x + y * y);
                }
            }
        }
        return new int[]{x, y};
    }
}
}