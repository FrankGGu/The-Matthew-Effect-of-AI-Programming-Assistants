#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> modifyColumns(vector<string>& matrix) {
        int n = matrix.size();
        if (n == 0) return {};
        int m = matrix[0].size();

        for (int j = 0; j < m; ++j) {
            char min_char = 'z' + 1;
            for (int i = 0; i < n; ++i) {
                min_char = min(min_char, matrix[i][j]);
            }

            for (int i = 0; i < n; ++i) {
                if (matrix[i][j] != min_char) {
                    matrix[i][j] = 'a';
                } else {
                    matrix[i][j] = 'b';
                }
            }
        }

        return matrix;
    }
};