#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int minimumMoves(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<pair<int, int>> zeros, stones;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    zeros.push_back({i, j});
                } else if (grid[i][j] > 1) {
                    for (int k = 0; k < grid[i][j] - 1; ++k) {
                        stones.push_back({i, j});
                    }
                }
            }
        }

        int m = zeros.size();
        vector<int> p(m);
        for (int i = 0; i < m; ++i) {
            p[i] = i;
        }

        int minMoves = INT_MAX;
        do {
            int currentMoves = 0;
            for (int i = 0; i < m; ++i) {
                currentMoves += abs(zeros[i].first - stones[p[i]].first) + abs(zeros[i].second - stones[p[i]].second);
            }
            minMoves = min(minMoves, currentMoves);
        } while (next_permutation(p.begin(), p.end()));

        return minMoves;
    }
};