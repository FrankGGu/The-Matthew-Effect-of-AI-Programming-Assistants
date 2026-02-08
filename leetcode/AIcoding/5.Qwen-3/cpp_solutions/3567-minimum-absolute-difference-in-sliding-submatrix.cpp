#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minAbsoluteDifference(vector<vector<int>>& matrix, int k) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int result = INT_MAX;

        for (int i = 0; i <= rows - k; ++i) {
            vector<int> temp;
            for (int j = 0; j < k; ++j) {
                for (int m = 0; m < k; ++m) {
                    temp.push_back(matrix[i + j][cols - k + m]);
                }
            }
            sort(temp.begin(), temp.end());
            for (int p = 1; p < k * k; ++p) {
                result = min(result, temp[p] - temp[p - 1]);
            }
        }

        return result;
    }
};