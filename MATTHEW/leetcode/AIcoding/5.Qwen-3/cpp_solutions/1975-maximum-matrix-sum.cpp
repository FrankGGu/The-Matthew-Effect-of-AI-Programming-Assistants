#include <iostream>
#include <vector>
#include <cmath>
#include <limits>

using namespace std;

class Solution {
public:
    long long matrixSum(int n, int m, vector<vector<int>>& matrix) {
        long long sum = 0;
        for (int j = 0; j < m; ++j) {
            int maxVal = -numeric_limits<int>::max();
            for (int i = 0; i < n; ++i) {
                maxVal = max(maxVal, matrix[i][j]);
            }
            sum += maxVal;
        }
        return sum;
    }
};