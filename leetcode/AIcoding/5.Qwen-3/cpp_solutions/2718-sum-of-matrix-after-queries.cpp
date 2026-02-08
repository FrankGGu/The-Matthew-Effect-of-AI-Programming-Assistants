#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int matrixSum(int n, int m, vector<vector<int>>& queries) {
        vector<vector<int>> matrix(n, vector<int>(m, 0));

        for (const auto& q : queries) {
            int r = q[0];
            int c = q[1];
            int v = q[2];
            matrix[r][c] += v;
        }

        int sum = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                sum += matrix[i][j];
            }
        }

        return sum;
    }
};