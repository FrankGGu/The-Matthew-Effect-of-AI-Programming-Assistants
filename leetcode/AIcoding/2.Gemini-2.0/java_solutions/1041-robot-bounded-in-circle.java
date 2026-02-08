class Solution {
    public boolean isRobotBounded(String instructions) {
        int x = 0, y = 0, dir = 0; // 0: North, 1: East, 2: South, 3: West
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        for (char instruction : instructions.toCharArray()) {
            if (instruction == 'G') {
                x += directions[dir][0];
                y += directions[dir][1];
            } else if (instruction == 'L') {
                dir = (dir + 3) % 4;
            } else {
                dir = (dir + 1) % 4;
            }
        }

        return (x == 0 && y == 0) || dir != 0;
    }
}