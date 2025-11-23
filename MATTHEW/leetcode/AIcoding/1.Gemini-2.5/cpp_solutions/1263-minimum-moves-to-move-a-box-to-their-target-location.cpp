#include <vector>
#include <string>
#include <queue>
#include <tuple>
#include <cstring> // For memset
#include <limits>  // For INT_MAX

class Solution {
public:
    int minPushBox(std::vector<std::string>& grid) {
        int R = grid.size();
        int C = grid[0].size();

        int start_pr, start_pc, start_br, start_bc, target_tr, target_tc;

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (grid[r][c] == 'S') {
                    start_pr = r;
                    start_pc = c;
                } else if (grid[r][c] == 'B') {
                    start_br = r;
                    start_bc = c;
                } else if (grid[r][c] == 'T') {
                    target_tr = r;
                    target_tc = c;
                }
            }
        }

        // dist[box_r][box_c][player_r][player_c] stores min pushes
        // Initialize with a large value (effectively infinity)
        // Max R, C is 20.
        int dist[20][20][20][20];
        memset(dist, 0x3f, sizeof(dist)); 

        // Directions: Up, Down, Left, Right
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        // 0-1 BFS using std::deque
        // Stores (box_r, box_c, player_r, player_c)
        std::deque<std::tuple<int, int, int, int>> dq;

        dist[start_br][start_bc][start_pr][start_pc] = 0;
        dq.push_front({start_br, start_bc, start_pr, start_pc});

        while (!dq.empty()) {
            auto [curr_br, curr_bc, curr_pr, curr_pc] = dq.front();
            dq.pop_front();

            int curr_pushes = dist[curr_br][curr_bc][curr_pr][curr_pc];

            if (curr_br == target_tr && curr_bc == target_tc) {
                return curr_pushes;
            }

            // Try player moves (0 cost for pushes)
            for (int i = 0; i < 4; ++i) {
                int npr = curr_pr + dr[i];
                int npc = curr_pc + dc[i];

                // Check if new player position is valid
                // In bounds, not a wall, and not the box's current position
                if (npr >= 0 && npr < R && npc >= 0 && npc < C &&
                    grid[npr][npc] != '#' &&
                    !(npr == curr_br && npc == curr_bc)) {

                    if (curr_pushes < dist[curr_br][curr_bc][npr][npc]) {
                        dist[curr_br][curr_bc][npr][npc] = curr_pushes;
                        dq.push_front({curr_br, curr_bc, npr, npc});
                    }
                }
            }

            // Try box pushes (1 cost for pushes)
            for (int i = 0; i < 4; ++i) {
                // Player needs to be at (curr_br - dr[i], curr_bc - dc[i]) to push box in direction i
                // This means player is behind the box, pushing it in direction (dr[i], dc[i])
                int req_pr = curr_br - dr[i];
                int req_pc = curr_bc - dc[i];

                // If player is in the correct position to push the box
                if (curr_pr == req_pr && curr_pc == req_pc) {
                    int nbr = curr_br + dr[i]; // New box row
                    int nbc = curr_bc + dc[i]; // New box col

                    // Check if new box position is valid
                    // In bounds, not a wall
                    if (nbr >= 0 && nbr < R && nbc >= 0 && nbc < C &&
                        grid[nbr][nbc] != '#') {

                        // New player position will be the old box position
                        int new_player_r = curr_br;
                        int new_player_c = curr_bc;

                        if (curr_pushes + 1 < dist[nbr][nbc][new_player_r][new_player_c]) {
                            dist[nbr][nbc][new_player_r][new_player_c] = curr_pushes + 1;
                            dq.push_back({nbr, nbc, new_player_r, new_player_c});
                        }
                    }
                }
            }
        }

        return -1; // Target not reachable
    }
};