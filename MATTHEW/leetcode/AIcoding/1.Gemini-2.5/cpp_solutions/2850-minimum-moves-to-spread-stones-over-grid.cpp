#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int minMoves(std::vector<std::vector<int>>& grid) {
        std::vector<std::pair<int, int>> sources;
        std::vector<std::pair<int, int>> destinations;

        for (int r = 0; r < 3; ++r) {
            for (int c = 0; c < 3; ++c) {
                if (grid[r][c] > 1) {
                    for (int i = 0; i < grid[r][c] - 1; ++i) {
                        sources.push_back({r, c});
                    }
                } else if (grid[r][c] == 0) {
                    destinations.push_back({r, c});
                }
            }
        }

        int N = sources.size(); 

        if (N == 0) {
            return 0;
        }

        std::vector<int> p(N);
        std::iota(p.begin(), p.end(), 0);

        int min_total_moves = 1e9; 

        do {
            int current_total_moves = 0;
            for (int i = 0; i < N; ++i) {
                current_total_moves += std::abs(sources[i].first - destinations[p[i]].first) +
                                       std::abs(sources[i].second - destinations[p[i]].second);
            }
            min_total_moves = std::min(min_total_moves, current_total_moves);
        } while (std::next_permutation(p.begin(), p.end()));

        return min_total_moves;
    }
};