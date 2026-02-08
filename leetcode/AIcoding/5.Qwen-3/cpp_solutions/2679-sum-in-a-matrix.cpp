#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int matrixSum(int n, int m, vector<vector<int>>& matrix) {
        for (int i = 0; i < n; ++i) {
            sort(matrix[i].begin(), matrix[i].end());
        }

        int sum = 0;
        for (int j = 0; j < m; ++j) {
            int maxVal = 0;
            for (int i = 0; i < n; ++i) {
                maxVal = max(maxVal, matrix[i][j]);
            }
            sum += maxVal;
        }

        return sum;
    }
};