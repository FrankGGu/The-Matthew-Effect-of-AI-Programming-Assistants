#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int areaOfMaxDiagonal(std::vector<std::vector<int>>& dimensions) {
        int max_diag_sq = 0;
        int max_area = 0;

        for (const auto& dim : dimensions) {
            int l = dim[0];
            int w = dim[1];
            int current_diag_sq = l * l + w * w;
            int current_area = l * w;

            if (current_diag_sq > max_diag_sq) {
                max_diag_sq = current_diag_sq;
                max_area = current_area;
            } else if (current_diag_sq == max_diag_sq) {
                max_area = std::max(max_area, current_area);
            }
        }
        return max_area;
    }
};