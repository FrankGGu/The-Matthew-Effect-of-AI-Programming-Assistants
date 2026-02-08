import java.util.*;

class Solution {
    int R, C;
    char[][] grid;
    int[] dr = {-1, 1, 0, 0}; // Up, Down, Left, Right
    int[] dc = {0, 0, -1, 1};

    // Helper to check if a cell is valid and not a wall
    boolean isValid(int r, int c) {
        return r >= 0 && r < R && c >= 0 && c < C && grid[r][c] != '#';
    }

    // BFS to check if player can reach (targetPR, targetPC) from (startPR, startPC)
    // without moving the box (boxR, boxC)
    boolean canPlayerReach(int startPR, int startPC, int targetPR, int targetPC, int boxR, int boxC) {
        if (startPR == targetPR && startPC == targetPC) {
            return true;
        }

        Queue<int[]> q = new LinkedList<>();
        boolean[][] visited = new boolean[R][C];

        q.offer(new int[]{startPR, startPC});
        visited[startPR][startPC] = true;

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (isValid(nr, nc) && !visited[nr][nc]) {
                    // Player cannot move into the box's current position
                    if (nr == boxR && nc == boxC) {
                        continue;
                    }
                    if (nr == targetPR && nc == targetPC) {
                        return true;
                    }
                    visited[nr][nc] = true;
                    q.offer(new int[]{nr, nc});
                }
            }
        }
        return false;
    }

    public int minPushBox(char[][] grid) {
        this.grid = grid;
        R = grid.length;
        C = grid[0].length;

        int startPR = -1, startPC = -1;
        int startBR = -1, startBC = -1;
        int targetTR = -1, targetTC = -1;

        // Find initial positions of Player, Box, and Target
        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                if (grid[r][c] == 'S') {
                    startPR = r;
                    startPC = c;
                    grid[r][c] = '.'; // Player's initial spot becomes empty
                } else if (grid[r][c] == 'B') {
                    startBR = r;
                    startBC = c;
                    grid[r][c] = '.'; // Box's initial spot becomes empty
                } else if (grid[r][c] == 'T') {
                    targetTR = r;
                    targetTC = c;
                }
            }
        }

        // State: {box_r, box_c, player_r, player_c, pushes}
        Queue<int[]> q = new LinkedList<>();
        // Visited state: [box_r][box_c][player_r][player_c]
        boolean[][][][] visited = new boolean[R][C][R][C];

        q.offer(new int[]{startBR, startBC, startPR, startPC, 0});
        visited[startBR][startBC][startPR][startPC] = true;

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int br = curr[0];
            int bc = curr[1];
            int pr = curr[2];
            int pc = curr[3];
            int pushes = curr[4];

            if (br == targetTR && bc == targetTC) {
                return pushes;
            }

            // Try to push the box in 4 directions
            for (int i = 0; i < 4; i++) {
                // (nextBR, nextBC) is the potential new position of the box
                int nextBR = br + dr[i];
                int nextBC = bc + dc[i];

                // (playerPushR, playerPushC) is where the player needs to be to push the box
                // If box moves from (br,bc) to (nextBR,nextBC), player must be at (br-dr[i], bc-dc[i])
                int playerPushR = br - dr[i];
                int playerPushC = bc - dc[i];

                // Check if new box position is valid and not a wall
                if (!isValid(nextBR, nextBC)) {
                    continue;
                }

                // Check if player can reach (playerPushR, playerPushC) from (pr, pc)
                // without moving the box (current box position is br, bc)
                if (isValid(playerPushR, playerPushC) && 
                    canPlayerReach(pr, pc, playerPushR, playerPushC, br, bc)) {

                    // The player's new position after pushing the box will be the box's old position
                    int newPR = br;
                    int newPC = bc;

                    if (!visited[nextBR][nextBC][newPR][newPC]) {
                        visited[nextBR][nextBC][newPR][newPC] = true;
                        q.offer(new int[]{nextBR, nextBC, newPR, newPC, pushes + 1});
                    }
                }
            }
        }

        return -1; // Target not reachable
    }
}