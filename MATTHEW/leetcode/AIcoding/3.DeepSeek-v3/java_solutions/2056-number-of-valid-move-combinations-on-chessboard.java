class Solution {
    private int[][] directions = new int[][]{{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};
    private int n;
    private List<String> pieces;
    private int[][] positions;
    private int result = 0;

    public int countCombinations(String[] pieces, int[][] positions) {
        this.n = pieces.length;
        this.pieces = Arrays.asList(pieces);
        this.positions = positions;
        dfs(0);
        return result;
    }

    private void dfs(int index) {
        if (index == n) {
            if (isValid()) {
                result++;
            }
            return;
        }
        int x = positions[index][0] - 1;
        int y = positions[index][1] - 1;
        dfs(index + 1);
        for (int[] dir : directions) {
            if (!pieces.get(index).equals("queen") && ((dir[0] != 0 && dir[1] != 0) || (dir[0] == 0 && dir[1] == 0))) {
                continue;
            }
            if (pieces.get(index).equals("rook") && dir[0] != 0 && dir[1] != 0) {
                continue;
            }
            if (pieces.get(index).equals("bishop") && (dir[0] == 0 || dir[1] == 0)) {
                continue;
            }
            int nx = x + dir[0];
            int ny = y + dir[1];
            int steps = 1;
            while (nx >= 0 && nx < 8 && ny >= 0 && ny < 8) {
                int finalNx = nx;
                int finalNy = ny;
                int finalSteps = steps;
                positions[index] = new int[]{nx + 1, ny + 1};
                dfs(index + 1);
                positions[index] = new int[]{x + 1, y + 1};
                nx += dir[0];
                ny += dir[1];
                steps++;
            }
        }
    }

    private boolean isValid() {
        int[][] pos = new int[n][2];
        for (int i = 0; i < n; i++) {
            pos[i] = positions[i].clone();
        }
        boolean keepMoving = true;
        while (keepMoving) {
            keepMoving = false;
            Set<String> occupied = new HashSet<>();
            boolean conflict = false;
            for (int i = 0; i < n; i++) {
                int dx = pos[i][0] - (positions[i][0] - 1) - 1;
                int dy = pos[i][1] - (positions[i][1] - 1) - 1;
                int sx = dx == 0 ? 0 : dx / Math.abs(dx);
                int sy = dy == 0 ? 0 : dy / Math.abs(dy);
                if (dx != 0 || dy != 0) {
                    keepMoving = true;
                    pos[i][0] -= sx;
                    pos[i][1] -= sy;
                }
                String key = pos[i][0] + "," + pos[i][1];
                if (occupied.contains(key)) {
                    conflict = true;
                }
                occupied.add(key);
            }
            if (conflict) {
                return false;
            }
        }
        return true;
    }
}