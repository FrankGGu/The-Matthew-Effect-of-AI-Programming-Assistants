class Solution {
    public boolean robot(String command, int[][] obstacles, int x, int y) {
        int cx = 0, cy = 0;
        for (char c : command.toCharArray()) {
            if (c == 'U') {
                cy++;
            } else {
                cx++;
            }
        }

        if (!canReach(command, x, y, cx, cy)) {
            return false;
        }

        for (int[] obstacle : obstacles) {
            int ox = obstacle[0], oy = obstacle[1];
            if (ox <= x && oy <= y && canReach(command, ox, oy, cx, cy)) {
                return false;
            }
        }

        return true;
    }

    private boolean canReach(String command, int x, int y, int cx, int cy) {
        int loops = Math.min(x / cx, y / cy);
        int nx = loops * cx;
        int ny = loops * cy;
        if (nx == x && ny == y) {
            return true;
        }

        for (char c : command.toCharArray()) {
            if (nx == x && ny == y) {
                return true;
            }
            if (c == 'U') {
                ny++;
            } else {
                nx++;
            }
            if (nx > x || ny > y) {
                return false;
            }
        }
        return nx == x && ny == y;
    }
}