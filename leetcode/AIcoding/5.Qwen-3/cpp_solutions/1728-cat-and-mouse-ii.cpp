#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>
#include <algorithm>

using namespace std;

class Solution {
public:
    int catMouseGame(vector<vector<int>>& graph, int catJump, int mouseJump) {
        int n = graph.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(2, -1)));
        queue<pair<int, int>> q;

        for (int m = 0; m < n; ++m) {
            for (int c = 0; c < n; ++c) {
                dp[m][c][0] = m == c ? 1 : -1;
                dp[m][c][1] = m == c ? 1 : -1;
                if (m == c) {
                    q.push({m, c});
                }
            }
        }

        for (int m = 0; m < n; ++m) {
            for (int c = 0; c < n; ++c) {
                if (m == 0) {
                    dp[m][c][0] = 0;
                    q.push({m, c});
                }
                if (m == 0) {
                    dp[m][c][1] = 0;
                    q.push({m, c});
                }
            }
        }

        while (!q.empty()) {
            auto [m, c] = q.front();
            q.pop();

            for (int turn = 0; turn < 2; ++turn) {
                int prev_m = turn == 0 ? m : c;
                int prev_c = turn == 0 ? c : m;
                int prev_turn = turn == 0 ? 1 : 0;

                if (dp[prev_m][prev_c][prev_turn] != -1) continue;

                bool is_mouse_turn = turn == 0;
                int jump = is_mouse_turn ? mouseJump : catJump;
                int start = is_mouse_turn ? prev_m : prev_c;
                int end = is_mouse_turn ? prev_c : prev_m;

                int result = -1;
                for (int next : graph[start]) {
                    int next_m = is_mouse_turn ? next : prev_m;
                    int next_c = is_mouse_turn ? prev_c : next;
                    if (dp[next_m][next_c][prev_turn] != -1) {
                        result = dp[next_m][next_c][prev_turn];
                        break;
                    }
                }

                if (result != -1) {
                    dp[prev_m][prev_c][prev_turn] = result;
                    q.push({prev_m, prev_c});
                } else {
                    int count = 0;
                    for (int next : graph[start]) {
                        int next_m = is_mouse_turn ? next : prev_m;
                        int next_c = is_mouse_turn ? prev_c : next;
                        if (dp[next_m][next_c][prev_turn] == -1) {
                            ++count;
                        }
                    }

                    if (count == 0) {
                        dp[prev_m][prev_c][prev_turn] = 2;
                        q.push({prev_m, prev_c});
                    }
                }
            }
        }

        return dp[0][0][0];
    }
};