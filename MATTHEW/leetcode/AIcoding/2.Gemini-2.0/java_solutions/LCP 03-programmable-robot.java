class Solution {
    public boolean programmableRobot(int m, int n, int[] startPos, int[] targetPos, String instructions) {
        int x = startPos[0];
        int y = startPos[1];
        for (char c : instructions.toCharArray()) {
            if (c == 'U') {
                if (x - 1 >= 0) {
                    x--;
                }
            } else if (c == 'D') {
                if (x + 1 < m) {
                    x++;
                }
            } else if (c == 'L') {
                if (y - 1 >= 0) {
                    y--;
                }
            } else {
                if (y + 1 < n) {
                    y++;
                }
            }
            if (x == targetPos[0] && y == targetPos[1]) {
                return true;
            }
        }
        return false;
    }
}