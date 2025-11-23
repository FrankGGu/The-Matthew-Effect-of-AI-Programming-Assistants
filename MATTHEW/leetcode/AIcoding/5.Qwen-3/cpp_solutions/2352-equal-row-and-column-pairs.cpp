#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>

using namespace std;

class Solution {
public:
    int equalPairs(vector<vector<int>>& grid) {
        unordered_map<string, int> rowMap;
        int n = grid.size();

        for (int i = 0; i < n; ++i) {
            string rowKey;
            for (int j = 0; j < n; ++j) {
                rowKey += to_string(grid[i][j]) + ",";
            }
            rowMap[rowKey]++;
        }

        int count = 0;
        for (int j = 0; j < n; ++j) {
            string colKey;
            for (int i = 0; i < n; ++i) {
                colKey += to_string(grid[i][j]) + ",";
            }
            count += rowMap[colKey];
        }

        return count;
    }
};