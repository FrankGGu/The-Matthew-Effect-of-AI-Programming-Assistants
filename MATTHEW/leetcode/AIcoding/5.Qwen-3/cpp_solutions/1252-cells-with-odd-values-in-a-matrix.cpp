#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int oddCells(int m, int n, vector<vector<int>>& indices) {
        vector<vector<int>> matrix(m, vector<int>(n, 0));
        for (const auto& idx : indices) {
            int x = idx[0];
            int y = idx[1];
            for (int i = 0; i < m; ++i) {
                matrix[i][y]++;
            }
            for (int j = 0; j < n; ++j) {
                matrix[x][j]++;
            }
        }
        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] % 2 != 0) {
                    ++count;
                }
            }
        }
        return count;
    }
};