#include <vector>
#include <queue>
#include <set>
#include <utility>

class Solution {
public:
    int minFlips(std::vector<std::vector<int>>& mat) {
        int M = mat.size();
        int N = mat[0].size();

        int initial_state = 0;
        for (int r = 0; r < M; ++r) {
            for (int c = 0; c < N; ++c) {
                if (mat[r][c] == 1) {
                    initial_state |= (1 << (r * N + c));
                }
            }
        }

        if (initial_state == 0) {
            return 0;
        }

        std::queue<std::pair<int, int>> q;
        std::set<int> visited;

        q.push({initial_state, 0});
        visited.insert(initial_state);

        int dr[] = {0, 0, 0, 1, -1};
        int dc[] = {0, 1, -1, 0, 0};

        while (!q.empty()) {
            std::pair<int, int> current = q.front();
            q.pop();
            int current_state = current.first;
            int flips = current.second;

            for (int r_flip = 0; r_flip < M; ++r_flip) {
                for (int c_flip = 0; c_flip < N; ++c_flip) {
                    int next_state = current_state;

                    for (int i = 0; i < 5; ++i) {
                        int nr = r_flip + dr[i];
                        int nc = c_flip + dc[i];

                        if (nr >= 0 && nr < M && nc >= 0 && nc < N) {
                            int bit_pos = nr * N + nc;
                            next_state ^= (1 << bit_pos);
                        }
                    }

                    if (next_state == 0) {
                        return flips + 1;
                    }

                    if (visited.find(next_state) == visited.end()) {
                        visited.insert(next_state);
                        q.push({next_state, flips + 1});
                    }
                }
            }
        }

        return -1;
    }
};