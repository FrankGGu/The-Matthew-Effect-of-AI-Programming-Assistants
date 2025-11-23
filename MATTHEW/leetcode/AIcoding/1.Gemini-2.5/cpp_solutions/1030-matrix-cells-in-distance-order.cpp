#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> allCellsDistOrder(int R, int C, int r0, int c0) {
        std::vector<std::pair<int, std::vector<int>>> cellsWithDist;

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                int dist = std::abs(r - r0) + std::abs(c - c0);
                cellsWithDist.push_back({dist, {r, c}});
            }
        }

        std::sort(cellsWithDist.begin(), cellsWithDist.end(), [](const auto& a, const auto& b) {
            return a.first < b.first;
        });

        std::vector<std::vector<int>> result;
        result.reserve(cellsWithDist.size());
        for (const auto& p : cellsWithDist) {
            result.push_back(p.second);
        }

        return result;
    }
};