#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long maxValueSum(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        vector<vector<long long>> topLeft(m, vector<long long>(n, LLONG_MIN));
        vector<vector<long long>> topRight(m, vector<long long>(n, LLONG_MIN));
        vector<vector<long long>> bottomLeft(m, vector<long long>(n, LLONG_MIN));
        vector<vector<long long>> bottomRight(m, vector<long long>(n, LLONG_MIN));

        topLeft[0][0] = grid[0][0];
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) continue;
                long long val = LLONG_MIN;
                if (i > 0) val = max(val, topLeft[i-1][j]);
                if (j > 0) val = max(val, topLeft[i][j-1]);
                if (val != LLONG_MIN) topLeft[i][j] = val + grid[i][j];
            }
        }

        topRight[0][n-1] = grid[0][n-1];
        for (int i = 0; i < m; ++i) {
            for (int j = n-1; j >= 0; --j) {
                if (i == 0 && j == n-1) continue;
                long long val = LLONG_MIN;
                if (i > 0) val = max(val, topRight[i-1][j]);
                if (j < n-1) val = max(val, topRight[i][j+1]);
                if (val != LLONG_MIN) topRight[i][j] = val + grid[i][j];
            }
        }

        bottomLeft[m-1][0] = grid[m-1][0];
        for (int i = m-1; i >= 0; --i) {
            for (int j = 0; j < n; ++j) {
                if (i == m-1 && j == 0) continue;
                long long val = LLONG_MIN;
                if (i < m-1) val = max(val, bottomLeft[i+1][j]);
                if (j > 0) val = max(val, bottomLeft[i][j-1]);
                if (val != LLONG_MIN) bottomLeft[i][j] = val + grid[i][j];
            }
        }

        bottomRight[m-1][n-1] = grid[m-1][n-1];
        for (int i = m-1; i >= 0; --i) {
            for (int j = n-1; j >= 0; --j) {
                if (i == m-1 && j == n-1) continue;
                long long val = LLONG_MIN;
                if (i < m-1) val = max(val, bottomRight[i+1][j]);
                if (j < n-1) val = max(val, bottomRight[i][j+1]);
                if (val != LLONG_MIN) bottomRight[i][j] = val + grid[i][j];
            }
        }

        long long res = 0;
        for (int i = 1; i < m-1; ++i) {
            for (int j = 1; j < n-1; ++j) {
                long long sum1 = topLeft[i-1][j] + topRight[i][j+1] + bottomLeft[i+1][j] + bottomRight[i][j-1];
                long long sum2 = topLeft[i][j-1] + topRight[i-1][j] + bottomLeft[i][j+1] + bottomRight[i+1][j];
                res = max(res, max(sum1, sum2));
            }
        }

        return res;
    }
};