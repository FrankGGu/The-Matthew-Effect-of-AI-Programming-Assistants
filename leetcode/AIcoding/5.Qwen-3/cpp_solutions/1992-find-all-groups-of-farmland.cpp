#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> findFarmland(vector<vector<int>>& land) {
        int m = land.size();
        int n = land[0].size();
        vector<vector<int>> result;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (land[i][j] == 1) {
                    int x = i, y = j;
                    while (x + 1 < m && land[x + 1][y] == 1) ++x;
                    while (y + 1 < n && land[x][y + 1] == 1) ++y;
                    result.push_back({i, j, x, y});
                    for (int a = i; a <= x; ++a) {
                        for (int b = j; b <= y; ++b) {
                            land[a][b] = 0;
                        }
                    }
                }
            }
        }

        return result;
    }
};