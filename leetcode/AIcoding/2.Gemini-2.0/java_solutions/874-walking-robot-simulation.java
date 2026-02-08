class Solution {
    public int robotSim(int[] commands, int[][] obstacles) {
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int directionIndex = 0;
        int x = 0, y = 0;
        int maxDistance = 0;

        Set<String> obstacleSet = new HashSet<>();
        for (int[] obstacle : obstacles) {
            obstacleSet.add(obstacle[0] + "," + obstacle[1]);
        }

        for (int command : commands) {
            if (command == -2) {
                directionIndex = (directionIndex + 3) % 4;
            } else if (command == -1) {
                directionIndex = (directionIndex + 1) % 4;
            } else {
                for (int i = 0; i < command; i++) {
                    int nextX = x + directions[directionIndex][0];
                    int nextY = y + directions[directionIndex][1];
                    if (obstacleSet.contains(nextX + "," + nextY)) {
                        break;
                    }
                    x = nextX;
                    y = nextY;
                    maxDistance = Math.max(maxDistance, x * x + y * y);
                }
            }
        }

        return maxDistance;
    }
}