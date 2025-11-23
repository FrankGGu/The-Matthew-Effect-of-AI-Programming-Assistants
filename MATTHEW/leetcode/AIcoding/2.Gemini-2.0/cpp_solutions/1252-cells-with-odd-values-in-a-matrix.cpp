#include <vector>

using namespace std;

class Solution {
public:
    int oddCells(int m, int n, vector<vector<int>>& indices) {
        vector<vector<int>> matrix(m, vector<int>(n, 0));
        for (auto& index : indices) {
            int row = index[0];
            int col = index[1];
            for (int j = 0; j < n; ++j) {
                matrix[row][j]++;
            }
            for (int i = 0; i < m; ++i) {
                matrix[i][col]++;
            }
        }
        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] % 2 != 0) {
                    count++;
                }
            }
        }
        return count;
    }
};