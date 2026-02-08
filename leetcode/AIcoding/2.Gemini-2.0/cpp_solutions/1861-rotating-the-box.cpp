#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<char>> rotateTheBox(vector<vector<char>>& box) {
        int m = box.size();
        int n = box[0].size();
        vector<vector<char>> rotated(n, vector<char>(m));

        for (int i = 0; i < m; ++i) {
            int bottom = n - 1;
            for (int j = n - 1; j >= 0; --j) {
                if (box[i][j] == '#') {
                    box[i][j] = '.';
                    box[i][bottom] = '#';
                    bottom--;
                } else if (box[i][j] == '*') {
                    bottom = j - 1;
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                rotated[j][m - 1 - i] = box[i][j];
            }
        }

        return rotated;
    }
};