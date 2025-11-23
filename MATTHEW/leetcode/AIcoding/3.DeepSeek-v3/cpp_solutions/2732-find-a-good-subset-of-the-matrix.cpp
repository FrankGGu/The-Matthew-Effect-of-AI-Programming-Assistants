#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> goodSubsetofBinaryMatrix(vector<vector<int>>& grid) {
        unordered_map<int, int> seen;
        int m = grid.size();
        int n = grid[0].size();

        for (int i = 0; i < m; ++i) {
            int mask = 0;
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    mask |= (1 << j);
                }
            }
            if (mask == 0) {
                return {i};
            }
            for (auto [key, val] : seen) {
                if ((key & mask) == 0) {
                    return {val, i};
                }
            }
            seen[mask] = i;
        }
        return {};
    }
};