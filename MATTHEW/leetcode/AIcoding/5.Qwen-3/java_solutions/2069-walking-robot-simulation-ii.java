public class Solution {

import java.util.*;

public class Robot {
    int[][] commands;
    int[][] obstacles;
    int[] position;
    int direction;
    int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public Robot(int width, int height) {
        commands = new int[0][];
        obstacles = new int[0][];
        position = new int[]{0, 0};
        direction = 0;
    }

    public void setCommands(int[] commands) {
        this.commands = new int[commands.length][1];
        for (int i = 0; i < commands.length; i++) {
            this.commands[i][0] = commands[i];
        }
    }

    public void setObstacles(int[][] obstacles) {
        this.obstacles = obstacles;
    }

    public int[] getFinalPosition() {
        Set<String> obstacleSet = new HashSet<>();
        for (int[] obstacle : obstacles) {
            obstacleSet.add(obstacle[0] + "," + obstacle[1]);
        }

        for (int[] command : commands) {
            int move = command[0];
            for (int i = 0; i < move; i++) {
                int[] next = new int[]{position[0] + directions[direction][0], position[1] + directions[direction][1]};
                String key = next[0] + "," + next[1];
                if (obstacleSet.contains(key)) {
                    break;
                }
                position = next;
            }
        }

        return position;
    }
}
}