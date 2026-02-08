#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maxDiff(int n, int m, vector<vector<int>>& grid) {
        vector<int> rowMax(n, INT_MIN);
        vector<int> rowMin(n, INT_MAX);
        vector<int> colMax(m, INT_MIN);
        vector<int> colMin(m, INT_MAX);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                rowMax[i] = max(rowMax[i], grid[i][j]);
                rowMin[i] = min(rowMin[i], grid[i][j]);
                colMax[j] = max(colMax[j], grid[i][j]);
                colMin[j] = min(colMin[j], grid[i][j]);
            }
        }

        int maxDiff = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                int diff = max(rowMax[i], colMax[j]) - min(rowMin[i], colMin[j]);
                maxDiff = max(maxDiff, diff);
            }
        }

        return maxDiff;
    }
};