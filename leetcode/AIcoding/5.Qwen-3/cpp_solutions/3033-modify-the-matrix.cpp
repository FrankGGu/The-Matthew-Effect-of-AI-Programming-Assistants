#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> modifyMatrix(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();
        vector<vector<int>> result(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == 0) {
                    for (int k = 0; k < m; ++k) {
                        result[k][j] = 0;
                    }
                    for (int l = 0; l < n; ++l) {
                        result[i][l] = 0;
                    }
                } else {
                    result[i][j] = matrix[i][j];
                }
            }
        }

        return result;
    }
};