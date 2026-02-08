class Solution {
    public int robotSim(int[] commands, int[][] obstacles) {
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int x = 0, y = 0, d = 0;
        Set<String> obstacleSet = new HashSet<>();
        for (int[] obs : obstacles) {
            obstacleSet.add(obs[0] + "," + obs[1]);
        }
        int maxDistance = 0;

        for (int command : commands) {
            if (command == -2) {
                d = (d + 3) % 4;
            } else if (command == -1) {
                d = (d + 1) % 4;
            } else {
                for (int i = 0; i < command; i++) {
                    int newX = x + directions[d][0];
                    int newY = y + directions[d][1];
                    if (!obstacleSet.contains(newX + "," + newY)) {
                        x = newX;
                        y = newY;
                        maxDistance = Math.max(maxDistance, x * x + y * y);
                    } else {
                        break;
                    }
                }
            }
        }
        return maxDistance;
    }
}