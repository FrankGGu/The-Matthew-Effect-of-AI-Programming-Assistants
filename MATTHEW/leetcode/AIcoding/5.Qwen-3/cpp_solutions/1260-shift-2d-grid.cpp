#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> shiftGrid(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        int total = m * n;
        vector<vector<int>> result(m, vector<int>(n, 0));

        for (int i = 0; i < total; i++) {
            int new_index = (i + k) % total;
            int new_row = new_index / n;
            int new_col = new_index % n;
            result[new_row][new_col] = grid[i / n][i % n];
        }

        return result;
    }
};