class Solution {
    public int[][] ballGame(int num, String[] plate) {
        int m = plate.length;
        int n = plate[0].length();
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        List<int[]> result = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (plate[i].charAt(j) == 'O') {
                    for (int[] dir : directions) {
                        int x = i + dir[0];
                        int y = j + dir[1];
                        if (x >= 0 && x < m && y >= 0 && y < n && plate[x].charAt(y) == '.') {
                            if (canReachExit(x, y, dir, plate, num)) {
                                result.add(new int[]{x, y});
                            }
                        }
                    }
                }
            }
        }

        int[][] res = new int[result.size()][2];
        for (int i = 0; i < res.length; i++) {
            res[i] = result.get(i);
        }
        return res;
    }

    private boolean canReachExit(int x, int y, int[] dir, String[] plate, int steps) {
        int m = plate.length;
        int n = plate[0].length();
        while (steps >= 0) {
            if (x < 0 || x >= m || y < 0 || y >= n) {
                return true;
            }
            if (plate[x].charAt(y) == 'O') {
                return false;
            }
            if (plate[x].charAt(y) == 'W') {
                dir = new int[]{-dir[1], dir[0]};
            } else if (plate[x].charAt(y) == 'E') {
                dir = new int[]{dir[1], -dir[0]};
            }
            x += dir[0];
            y += dir[1];
            steps--;
        }
        return false;
    }
}