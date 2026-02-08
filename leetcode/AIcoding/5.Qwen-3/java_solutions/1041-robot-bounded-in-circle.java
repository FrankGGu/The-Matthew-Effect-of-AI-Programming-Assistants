public class Solution {
    public boolean isRobotBounded(String instructions) {
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int x = 0, y = 0, dir = 0;

        for (char c : instructions.toCharArray()) {
            if (c == 'G') {
                x += directions[dir][0];
                y += directions[dir][1];
            } else if (c == 'L') {
                dir = (dir + 3) % 4;
            } else {
                dir = (dir + 1) % 4;
            }
        }

        return (x == 0 && y == 0) || dir != 0;
    }
}