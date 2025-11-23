class Solution {
    public int robotSim(int[] commands, int[][] obstacles) {
        Set<Pair<Integer, Integer>> obstacleSet = new HashSet<>();
        for (int[] obs : obstacles) {
            obstacleSet.add(new Pair<>(obs[0], obs[1]));
        }

        int x = 0, y = 0, maxDistance = 0;
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int dir = 0;

        for (int command : commands) {
            if (command == -2) {
                dir = (dir + 3) % 4;
            } else if (command == -1) {
                dir = (dir + 1) % 4;
            } else {
                for (int step = 0; step < command; step++) {
                    int newX = x + directions[dir][0];
                    int newY = y + directions[dir][1];
                    if (!obstacleSet.contains(new Pair<>(newX, newY))) {
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