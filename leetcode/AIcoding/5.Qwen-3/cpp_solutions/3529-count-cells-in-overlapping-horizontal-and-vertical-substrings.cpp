#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countCells(int n, int m, vector<string>& s) {
        vector<vector<int>> grid(n, vector<int>(m, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (s[i][j] == '1') {
                    for (int k = 0; k < m; ++k) {
                        grid[i][k]++;
                    }
                    for (int k = 0; k < n; ++k) {
                        grid[k][j]++;
                    }
                }
            }
        }
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] > 1) {
                    ++count;
                }
            }
        }
        return count;
    }
};