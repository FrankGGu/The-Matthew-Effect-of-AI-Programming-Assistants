import java.util.HashSet;
import java.util.Set;

class Solution {
    public int robotSim(int[] commands, int[][] obstacles) {
        int[] dx = {0, 1, 0, -1};
        int[] dy = {1, 0, -1, 0};

        int x = 0;
        int y = 0;
        int dir = 0;

        Set<Long> obstacleSet = new HashSet<>();
        for (int[] obs : obstacles) {
            long ox = obs[0];
            long oy = obs[1];
            obstacleSet.add((ox << 32) | (oy & 0xFFFFFFFFL));
        }

        long maxDistSq = 0;

        for (int command : commands) {
            if (command == -2) {
                dir = (dir + 3) % 4;
            } else if (command == -1) {
                dir = (dir + 1) % 4;
            } else {
                for (int i = 0; i < command; i++) {
                    int nextX = x + dx[dir];
                    int nextY = y + dy[dir];

                    long nextPosKey = ((long)nextX << 32) | ((long)nextY & 0xFFFFFFFFL);

                    if (obstacleSet.contains(nextPosKey)) {
                        break;
                    } else {
                        x = nextX;
                        y = nextY;
                    }
                }
            }
            maxDistSq = Math.max(maxDistSq, (long)x * x + (long)y * y);
        }

        return (int) maxDistSq;
    }
}