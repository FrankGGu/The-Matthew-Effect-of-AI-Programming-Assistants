import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.Queue;

class Solution {
    private int N, M;
    private char[][] grid;
    private int[] dr = {-1, 1, 0, 0}; // Up, Down, Left, Right
    private int[] dc = {0, 0, -1, 1};

    private boolean canPlayerReach(int start_pr, int start_pc, int target_pr, int target_pc, int box_r, int box_c) {
        if (start_pr == target_pr && start_pc == target_pc) {
            return true;
        }

        Queue<int[]> playerQ = new ArrayDeque<>();
        boolean[][] playerVisited = new boolean[N][M];

        playerQ.offer(new int[]{start_pr, start_pc});
        playerVisited[start_pr][start_pc] = true;

        while (!playerQ.isEmpty()) {
            int[] curr = playerQ.poll();
            int r = curr[0];
            int c = curr[1];

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < N && nc >= 0 && nc < M && grid[nr][nc] != '#' && !playerVisited[nr][nc]) {
                    if (nr == box_r && nc == box_c) { // Player cannot move through the box
                        continue;
                    }
                    if (nr == target_pr && nc == target_pc) {
                        return true;
                    }
                    playerVisited[nr][nc] = true;
                    playerQ.offer(new int[]{nr, nc});
                }
            }
        }
        return false;
    }

    public int minPushBox(char[][] grid) {
        this.grid = grid;
        N = grid.length;
        M = grid[0].length;

        int box_start_r = -1, box_start_c = -1;
        int player_start_r = -1, player_start_c = -1;
        int target_r = -1, target_c = -1;

        for (int r = 0; r < N; r++) {
            for (int c = 0; c < M; c++) {
                if (grid[r][c] == 'B') {
                    box_start_r = r;
                    box_start_c = c;
                } else if (grid[r][c] == 'S') {
                    player_start_r = r;
                    player_start_c = c;
                } else if (grid[r][c] == 'T') {
                    target_r = r;
                    target_c = c;
                }
            }
        }

        int[][][][] dist = new int[N][M][N][M];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++) {
                for (int k = 0; k < N; k++) {
                    Arrays.fill(dist[i][j][k], Integer.MAX_VALUE);
                }
            }
        }

        Queue<int[]> q = new ArrayDeque<>(); 

        q.offer(new int[]{box_start_r, box_start_c, player_start_r, player_start_c});
        dist[box_start_r][box_start_c][player_start_r][player_start_c] = 0;

        while (!q.isEmpty()) {
            int[] currState = q.poll();
            int br = currState[0];
            int bc = currState[1];
            int pr = currState[2];
            int pc = currState[3];
            int pushes = dist[br][bc][pr][pc];

            if (br == target_r && bc == target_c) {
                return pushes;
            }

            for (int i = 0; i < 4; i++) {
                int next_br = br + dr[i]; 
                int next_bc = bc + dc[i];

                int player_pos_to_push_r = br - dr[i];
                int player_pos_to_push_c = bc - dc[i];

                if (next_br < 0 || next_br >= N || next_bc < 0 || next_bc >= M || grid[next_br][next_bc] == '#') {
                    continue;
                }

                if (player_pos_to_push_r < 0 || player_pos_to_push_r >= N || player_pos_to_push_c < 0 || player_pos_to_push_c >= M || grid[player_pos_to_push_r][player_pos_to_push_c] == '#') {
                    continue;
                }

                if (canPlayerReach(pr, pc, player_pos_to_push_r, player_pos_to_push_c, br, bc)) {
                    int new_pr = br;
                    int new_pc = bc;

                    if (pushes + 1 < dist[next_br][next_bc][new_pr][new_pc]) {
                        dist[next_br][next_bc][new_pr][new_pc] = pushes + 1;
                        q.offer(new int[]{next_br, next_bc, new_pr, new_pc});
                    }
                }
            }
        }

        return -1;
    }
}