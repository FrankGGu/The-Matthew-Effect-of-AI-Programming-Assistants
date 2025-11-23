#include <vector>

using namespace std;

class Solution {
public:
    vector<int> goodSubsetofBinaryMatrix(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        for (int i = 0; i < m; ++i) {
            bool allZero = true;
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == 1) {
                    allZero = false;
                    break;
                }
            }
            if (allZero) {
                return {i};
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = i + 1; j < m; ++j) {
                bool good = true;
                for (int k = 0; k < n; ++k) {
                    if (matrix[i][k] == 1 && matrix[j][k] == 1) {
                        good = false;
                        break;
                    }
                }
                if (good) {
                    return {i, j};
                }
            }
        }

        return {};
    }
};