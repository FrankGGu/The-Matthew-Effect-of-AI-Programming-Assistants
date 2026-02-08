#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long gridGame(vector<vector<int>>& grid) {
        int n = grid.size();
        long long top = 0, bottom = 0;
        for (int i = 0; i < n; i++) {
            top += grid[0][i];
        }
        for (int i = 0; i < n; i++) {
            bottom += grid[1][i];
        }
        long long res = LLONG_MAX;
        long long left = 0, right = 0;
        for (int i = 0; i < n; i++) {
            right = top - left - grid[0][i];
            res = min(res, max(left, right));
            left += grid[0][i];
        }
        return res;
    }
};