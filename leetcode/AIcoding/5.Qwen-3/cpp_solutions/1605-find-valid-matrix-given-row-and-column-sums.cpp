#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> findValidMatrix(int n, int m, vector<int>& rowSum, vector<int>& colSum) {
        vector<vector<int>> result(n, vector<int>(m, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                result[i][j] = min(rowSum[i], colSum[j]);
                rowSum[i] -= result[i][j];
                colSum[j] -= result[i][j];
            }
        }

        return result;
    }
};