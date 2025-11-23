import java.util.*;

public class Solution {
    public int[] simulateRobot(string commands, int[] obstacles) {
        Set<String> obstacleSet = new HashSet<>();
        for (int[] obstacle : obstacles) {
            obstacleSet.add(obstacle[0] + "," + obstacle[1]);
        }

        int x = 0, y = 0;
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int dir = 0;

        for (char command : commands.toCharArray()) {
            if (command == 'G') {
                int newX = x + directions[dir][0];
                int newY = y + directions[dir][1];
                if (!obstacleSet.contains(newX + "," + newY)) {
                    x = newX;
                    y = newY;
                }
            } else if (command == 'L') {
                dir = (dir + 3) % 4;
            } else if (command == 'R') {
                dir = (dir + 1) % 4;
            }
        }

        return new int[]{x, y};
    }
}