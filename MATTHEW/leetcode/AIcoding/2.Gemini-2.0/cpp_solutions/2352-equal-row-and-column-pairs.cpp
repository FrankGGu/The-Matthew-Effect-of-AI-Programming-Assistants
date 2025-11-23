#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int equalPairs(vector<vector<int>>& grid) {
        int n = grid.size();
        map<vector<int>, int> row_counts;
        for (int i = 0; i < n; ++i) {
            row_counts[grid[i]]++;
        }

        int count = 0;
        for (int j = 0; j < n; ++j) {
            vector<int> col;
            for (int i = 0; i < n; ++i) {
                col.push_back(grid[i][j]);
            }
            count += row_counts[col];
        }

        return count;
    }
};