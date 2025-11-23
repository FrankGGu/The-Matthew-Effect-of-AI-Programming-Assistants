#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> modifyColumns(vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return matrix;
        int m = matrix.size();
        int n = matrix[0].size();
        for (int j = 0; j < n; j += 2) {
            for (int i = 0; i < m; ++i) {
                matrix[i][j] *= 2;
            }
        }
        return matrix;
    }
};