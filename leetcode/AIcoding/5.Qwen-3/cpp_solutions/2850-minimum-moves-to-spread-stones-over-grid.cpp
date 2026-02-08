#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumMoves(vector<vector<int>>& grid) {
        vector<pair<int, int>> ones;
        vector<pair<int, int>> zeros;

        for (int i = 0; i < 4; ++i) {
            for (int j = 0; j < 4; ++j) {
                if (grid[i][j] == 1) {
                    ones.push_back({i, j});
                } else if (grid[i][j] == 0) {
                    zeros.push_back({i, j});
                }
            }
        }

        int total = 0;
        for (int i = 0; i < 4; ++i) {
            total += abs(ones[i].first - zeros[i].first) + abs(ones[i].second - zeros[i].second);
        }

        return total;
    }
};