#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<char>> rotateTheBox(vector<vector<char>>& box) {
        int m = box.size();
        int n = box[0].size();
        vector<vector<char>> result(n, vector<char>(m, ' '));

        for (int i = 0; i < m; ++i) {
            int last = n - 1;
            for (int j = n - 1; j >= 0; --j) {
                if (box[i][j] == '*') {
                    result[j][m - 1 - i] = '*';
                    last = j - 1;
                } else if (box[i][j] == '#') {
                    result[last][m - 1 - i] = '#';
                    last--;
                }
            }
        }

        return result;
    }
};