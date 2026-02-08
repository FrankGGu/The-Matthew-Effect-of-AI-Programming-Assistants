#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int spiralMatrixIII(int m, int n, int k) {
        vector<vector<int>> matrix(m, vector<int>(n));
        int dir[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int step = 1, d = 0, x = 0, y = 0;
        int count = 0;
        for (int i = 0; i < k; ++i) {
            for (int j = 0; j < 2; ++j) {
                for (int l = 0; l < step; ++l) {
                    if (x >= 0 && x < m && y >= 0 && y < n) {
                        count++;
                    }
                    x += dir[d][0];
                    y += dir[d][1];
                }
                d = (d + 1) % 4;
            }
            step++;
        }
        return count;
    }
};