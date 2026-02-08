#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> diagonalSort(std::vector<std::vector<int>>& mat) {
        std::unordered_map<int, std::vector<int>> diagonals;
        int m = mat.size(), n = mat[0].size();

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                diagonals[i - j].push_back(mat[i][j]);
            }
        }

        for (auto& diag : diagonals) {
            std::sort(diag.second.begin(), diag.second.end());
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                mat[i][j] = diagonals[i - j].back();
                diagonals[i - j].pop_back();
            }
        }

        return mat;
    }
};