class Solution {
    int width, height, foodX, foodY, catSpeed, mouseSpeed;
    int[][] jump = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {0, 0}};
    boolean[][][][][][] seen;
    String[] grid;

    public boolean canMouseWin(String[] grid, int catJump, int mouseJump, int[] mouse, int[] cat, int[] food) {
        this.grid = grid;
        height = grid.length;
        width = grid[0].length();
        catSpeed = catJump;
        mouseSpeed = mouseJump;
        foodX = food[0];
        foodY = food[1];
        seen = new boolean[height][width][height][width][2][1001];

        return dfs(mouse[0], mouse[1], cat[0], cat[1], 0, 0);
    }

    boolean dfs(int mx, int my, int cx, int cy, int turn, int depth) {
        if (depth > 1000) return false;
        if (mx == cx && my == cy) return false;
        if (mx == foodX && my == foodY) return true;
        if (cx == foodX && cy == foodY) return false;
        if (seen[mx][my][cx][cy][turn][depth]) return false;
        seen[mx][my][cx][cy][turn][depth] = true;

        if (turn == 0) {
            for (int[] j : jump) {
                for (int k = 0; k <= mouseSpeed; k++) {
                    int nmx = mx + k * j[0];
                    int nmy = my + k * j[1];
                    if (nmx >= 0 && nmx < height && nmy >= 0 && nmy < width && grid[nmx].charAt(nmy) != '#') {
                        if (dfs(nmx, nmy, cx, cy, 1, depth + 1)) return true;
                    } else {
                        break;
                    }
                }
            }
            return false;
        } else {
            for (int[] j : jump) {
                for (int k = 0; k <= catSpeed; k++) {
                    int ncx = cx + k * j[0];
                    int ncy = cy + k * j[1];
                    if (ncx >= 0 && ncx < height && ncy >= 0 && ncy < width && grid[ncx].charAt(ncy) != '#') {
                        if (!dfs(mx, my, ncx, ncy, 0, depth + 1)) return true;
                    } else {
                        break;
                    }
                }
            }
            return false;
        }
    }
}