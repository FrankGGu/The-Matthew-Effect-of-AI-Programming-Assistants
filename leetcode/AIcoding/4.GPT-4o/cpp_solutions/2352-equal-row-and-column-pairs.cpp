#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int equalPairs(vector<vector<int>>& grid) {
        unordered_map<string, int> rowCount;
        int n = grid.size();
        int count = 0;

        for (const auto& row : grid) {
            string rowKey;
            for (int num : row) {
                rowKey += to_string(num) + ",";
            }
            rowCount[rowKey]++;
        }

        for (int j = 0; j < n; j++) {
            string colKey;
            for (int i = 0; i < n; i++) {
                colKey += to_string(grid[i][j]) + ",";
            }
            count += rowCount[colKey];
        }

        return count;
    }
};