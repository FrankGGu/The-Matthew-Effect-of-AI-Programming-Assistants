#include <vector>
#include <cmath>
#include <numeric>

class Solution {
public:
    bool escapeGhosts(std::vector<std::vector<int>>& ghosts, std::vector<int>& target) {
        int player_dist = std::abs(target[0]) + std::abs(target[1]);

        for (const auto& ghost : ghosts) {
            int ghost_dist = std::abs(ghost[0] - target[0]) + std::abs(ghost[1] - target[1]);
            if (ghost_dist <= player_dist) {
                return false;
            }
        }

        return true;
    }
};