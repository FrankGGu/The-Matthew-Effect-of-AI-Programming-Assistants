#include <vector>
#include <queue>
#include <tuple>

class Solution {
public:
    int catAndMouse(std::vector<std::vector<int>>& graph) {
        int N = graph.size();

        // dp[mouse_pos][cat_pos][turn]
        // turn: 0 for mouse, 1 for cat
        // Values: 0 (DRAW), 1 (MOUSE_WIN), 2 (CAT_WIN)
        std::vector<std::vector<std::vector<int>>> dp(N, std::vector<std::vector<int>>(N, std::vector<int>(2, 0)));

        // outdegree[mouse_pos][cat_pos][turn]
        // Stores the number of moves that can still lead to a DRAW or a WIN for the current player.
        // If it drops to 0, all moves lead to a loss, so the current player loses.
        std::vector<std::vector<std::vector<int>>> outdegree(N, std::vector<std::vector<int>>(N, std::vector<int>(2)));

        // Precompute reverse graph for efficient backward propagation
        std::vector<std::vector<int>> rev_graph(N);
        for (int i = 0; i < N; ++i) {
            for (int neighbor : graph[i]) {
                rev_graph[neighbor].push_back(i);
            }
        }

        // Initialize outdegrees for all states
        for (int m = 0; m < N; ++m) {
            for (int c = 0; c < N; ++c) {
                // Mouse's turn (turn = 0)
                outdegree[m][c][0] = graph[m].size();
                // Cat's turn (turn = 1)
                outdegree[m][c][1] = graph[c].size();
                // Cat cannot move to hole 0, so adjust outdegree if 0 is a neighbor
                for (int node : graph[c]) {
                    if (node == 0) {
                        outdegree[m][c][1]--;
                        break; 
                    }
                }
            }
        }

        std::queue<std::tuple<int, int, int>> q; // (mouse_pos, cat_pos, turn)

        // Initialize queue with terminal states (mouse wins or cat wins)
        for (int m = 0; m < N; ++m) {
            for (int c = 0; c < N; ++c) {
                if (m == 0) { // Mouse reaches hole 0
                    if (dp[m][c][0] == 0) { dp[m][c][0] = 1; q.push({m, c, 0}); }
                    if (dp[m][c][1] == 0) { dp[m][c][1] = 1; q.push({m, c, 1}); }
                } else if (c == m) { // Cat catches mouse (and mouse is not at hole 0, covered by else if)
                    if (dp[m][c][0] == 0) { dp[m][c][0] = 2; q.push({m, c, 0}); }
                    if (dp[m][c][1] == 0) { dp[m][c][1] = 2; q.push({m, c, 1}); }
                }
            }
        }

        // BFS to determine outcomes of other states
        while (!q.empty()) {
            auto [curr_m, curr_c, curr_t] = q.front();
            q.pop();

            int winner = dp[curr_m][curr_c][curr_t];

            // Propagate backward to previous states
            if (curr_t == 0) { // Mouse's turn in (curr_m, curr_c, 0). This means Cat just moved to curr_c.
                // Previous state was (curr_m, prev_c, 1) where cat moved from prev_c to curr_c.
                // Cat cannot move to hole 0. If curr_c is 0, no cat move could have led here.
                if (curr_c == 0) continue; 

                for (int prev_c : rev_graph[curr_c]) {
                    // Cat cannot move from hole 0.
                    if (prev_c == 0) continue; 

                    if (dp[curr_m][prev_c][1] == 0) { // If cat's turn (1) at (curr_m, prev_c) is still undetermined (DRAW)
                        if (winner == 2) { // Cat won in (curr_m, curr_c, 0), and cat just moved to curr_c.
                                           // So, from (curr_m, prev_c, 1), cat can make a winning move.
                            dp[curr_m][prev_c][1] = 2;
                            q.push({curr_m, prev_c, 1});
                        } else { // Mouse won in (curr_m, curr_c, 0), and cat just moved to curr_c.
                                 // This move led to a loss for cat. Decrement outdegree.
                            outdegree[curr_m][prev_c][1]--;
                            if (outdegree[curr_m][prev_c][1] == 0) { // All cat's moves from (curr_m, prev_c) lead to mouse win.
                                dp[curr_m][prev_c][1] = 1; // So mouse wins from (curr_m, prev_c, 1).
                                q.push({curr_m, prev_c, 1});
                            }
                        }
                    }
                }
            } else { // Cat's turn in (curr_m, curr_c, 1). This means Mouse just moved to curr_m.
                // Previous state was (prev_m, curr_c, 0) where mouse moved from prev_m to curr_m.
                for (int prev_m : rev_graph[curr_m]) {
                    if (dp[prev_m][curr_c][0] == 0) { // If mouse's turn (0) at (prev_m, curr_c) is still undetermined (DRAW)
                        if (winner == 1) { // Mouse won in (curr_m, curr_c, 1), and mouse just moved to curr_m.
                                           // So, from (prev_m, curr_c, 0), mouse can make a winning move.
                            dp[prev_m][curr_c][0] = 1;
                            q.push({prev_m, curr_c, 0});
                        } else { // Cat won in (curr_m, curr_c, 1), and mouse just moved to curr_m.
                                 // This move led to a loss for mouse. Decrement outdegree.
                            outdegree[prev_m][curr_c][0]--;
                            if (outdegree[prev_m][curr_c][0] == 0) { // All mouse's moves from (prev_m, curr_c) lead to cat win.
                                dp[prev_m][curr_c][0] = 2; // So cat wins from (prev_m, curr_c, 0).
                                q.push({prev_m, curr_c, 0});
                            }
                        }
                    }
                }
            }
        }

        // The game starts with mouse at 1, cat at 2, mouse's turn (0).
        return dp[1][2][0];
    }
};