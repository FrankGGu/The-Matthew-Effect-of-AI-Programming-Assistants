class Solution {
    public int[][] ballGame(int num, String[] plate) {
        int m = plate.length;
        int n = plate[0].length();
        List<int[]> res = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (plate[i].charAt(j) == 'O') {
                    continue;
                }
                if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                    for (int d = 0; d < 4; d++) {
                        if (canReach(plate, i, j, d, num)) {
                            res.add(new int[]{i, j});
                            break;
                        }
                    }
                }
            }
        }
        return res.toArray(new int[res.size()][]);
    }

    private boolean canReach(String[] plate, int x, int y, int dir, int steps) {
        int m = plate.length;
        int n = plate[0].length();
        int[][] dirs = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}};
        while (steps >= 0) {
            if (x < 0 || x >= m || y < 0 || y >= n) {
                return false;
            }
            if (plate[x].charAt(y) == 'O') {
                return true;
            }
            char c = plate[x].charAt(y);
            if (c == 'E') {
                dir = (dir + 1) % 4;
            } else if (c == 'W') {
                dir = (dir + 3) % 4;
            }
            x += dirs[dir][0];
            y += dirs[dir][1];
            steps--;
        }
        return false;
    }
}