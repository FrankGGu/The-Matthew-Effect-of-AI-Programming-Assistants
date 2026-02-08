#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> fillGrid(int n, int m, vector<int>& a, vector<int>& b) {
        vector<vector<int>> grid(n, vector<int>(m, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (a[i] == 1 || b[j] == 1) {
                    grid[i][j] = 1;
                }
            }
        }
        return grid;
    }
};