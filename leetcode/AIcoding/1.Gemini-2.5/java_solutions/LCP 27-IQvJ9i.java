import java.util.HashSet;
import java.util.Set;

class Solution {

    private static final int[] dr = {0, 1, 0, -1}; // 0: Right, 1: Down, 2: Left, 3: Up
    private static final int[] dc = {1, 0, -1, 0};

    private static final int[] SLASH_REFLECT = {3, 2, 1, 0}; // For '/' mirror: Right->Up, Down->Left, Left->Down, Up->Right
    private static final int[] BACKSLASH_REFLECT = {1, 0, 3, 2}; // For '\' mirror: Right->Down, Down->Right, Left->Up, Up->Left

    public int[] findExitPoint(char[][] grid, int startR, int startC, int startDir) {
        int rows = grid.length;
        int cols = grid[0].length;

        int r = startR;
        int c = startC;
        int dir = startDir;

        Set<String> visitedStates = new HashSet<>();

        while (r >= 0 && r < rows && c >= 0 && c < cols) {
            String state = r + "," + c + "," + dir;
            if (!visitedStates.add(state)) {
                return null; // Ray entered a cycle, will not exit
            }

            char cell = grid[r][c];
            if (cell == '/') {
                dir = SLASH_REFLECT[dir];
            } else if (cell == '\\') {
                dir = BACKSLASH_REFLECT[dir];
            }
            // If cell is '.', direction remains unchanged

            r += dr[dir];
            c += dc[dir];
        }

        return new int[]{r, c}; // Ray exited the grid
    }
}