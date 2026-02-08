#include <vector>
#include <algorithm>

class Solution {
public:
    bool findRotation(std::vector<std::vector<int>>& mat, std::vector<std::vector<int>>& target) {
        if (mat == target) return true;
        int n = mat.size();
        for (int k = 0; k < 3; ++k) {
            // Transpose
            for (int i = 0; i < n; ++i) {
                for (int j = i + 1; j < n; ++j) {
                    std::swap(mat[i][j], mat[j][i]);
                }
            }
            // Reverse each row
            for (int i = 0; i < n; ++i) {
                std::reverse(mat[i].begin(), mat[i].end());
            }
            if (mat == target) return true;
        }
        return false;
    }
};