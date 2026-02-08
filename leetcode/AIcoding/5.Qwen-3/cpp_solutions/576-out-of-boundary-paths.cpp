#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
private:
    vector<vector<int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int m, n;
    int memo[101][101][101];

    int dfs(int i, int j, int steps) {
        if (i < 0 || i >= m || j < 0 || j >= n) {
            return 1;
        }
        if (steps == 0) {
            return 0;
        }
        if (memo[i][j][steps] != 0) {
            return memo[i][j][steps];
        }
        int res = 0;
        for (auto& dir : directions) {
            int ni = i + dir[0];
            int nj = j + dir[1];
            res += dfs(ni, nj, steps - 1);
        }
        memo[i][j][steps] = res;
        return res;
    }

public:
    int findPaths(int m, int n, int maxSteps, int startRow, int startCol) {
        this->m = m;
        this->n = n;
        memset(memo, 0, sizeof(memo));
        return dfs(startRow, startCol, maxSteps);
    }
};