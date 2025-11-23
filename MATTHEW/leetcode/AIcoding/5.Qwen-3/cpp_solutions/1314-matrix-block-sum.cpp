#include <vector>
#include <iostream>

using namespace std;

class Solution {
public:
    vector<vector<int>> matrixBlockSum(int n, int m, vector<vector<int>>& mat, int K) {
        vector<vector<int>> res(n, vector<int>(m, 0));
        vector<vector<int>> prefix(n + 1, vector<int>(m + 1, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                prefix[i + 1][j + 1] = mat[i][j] + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j];
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                int x1 = max(0, i - K);
                int y1 = max(0, j - K);
                int x2 = min(n - 1, i + K);
                int y2 = min(m - 1, j + K);
                res[i][j] = prefix[x2 + 1][y2 + 1] - prefix[x1][y2 + 1] - prefix[x2 + 1][y1] + prefix[x1][y1];
            }
        }

        return res;
    }
};