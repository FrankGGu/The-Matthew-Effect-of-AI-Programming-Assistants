#include <vector>
#include <unordered_map>

using namespace std;

vector<int> findDiagonalOrder(vector<vector<int>>& nums) {
    unordered_map<int, vector<int>> diagonals;
    int maxDiagonal = 0;

    for (int i = 0; i < nums.size(); ++i) {
        for (int j = 0; j < nums[i].size(); ++j) {
            diagonals[i + j].push_back(nums[i][j]);
            maxDiagonal = max(maxDiagonal, i + j);
        }
    }

    vector<int> result;
    for (int d = 0; d <= maxDiagonal; ++d) {
        if (d % 2 == 0) {
            for (int i = 0; i < diagonals[d].size(); ++i) {
                result.push_back(diagonals[d][i]);
            }
        } else {
            for (int i = diagonals[d].size() - 1; i >= 0; --i) {
                result.push_back(diagonals[d][i]);
            }
        }
    }

    return result;
}