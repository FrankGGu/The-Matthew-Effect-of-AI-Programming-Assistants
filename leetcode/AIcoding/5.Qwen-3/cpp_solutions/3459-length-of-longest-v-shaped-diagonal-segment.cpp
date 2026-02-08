#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int longestVShapedDiagonalSegment(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        if (rows == 0) return 0;
        int cols = matrix[0].size();
        if (cols == 0) return 0;

        int maxLen = 1;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                int len = 1;
                int r = i - 1, c = j + 1;
                while (r >= 0 && c < cols && matrix[r][c] == matrix[i][j]) {
                    len++;
                    r--;
                    c++;
                }
                r = i + 1;
                c = j - 1;
                while (r < rows && c >= 0 && matrix[r][c] == matrix[i][j]) {
                    len++;
                    r++;
                    c--;
                }
                maxLen = max(maxLen, len);
            }
        }

        return maxLen;
    }
};