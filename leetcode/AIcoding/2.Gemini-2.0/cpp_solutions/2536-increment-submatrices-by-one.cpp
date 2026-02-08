#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> rangeAddQueries(int n, vector<vector<int>>& queries) {
        vector<vector<int>> matrix(n, vector<int>(n, 0));

        for (auto& query : queries) {
            int row1 = query[0];
            int col1 = query[1];
            int row2 = query[2];
            int col2 = query[3];

            for (int i = row1; i <= row2; ++i) {
                for (int j = col1; j <= col2; ++j) {
                    matrix[i][j]++;
                }
            }
        }

        return matrix;
    }
};