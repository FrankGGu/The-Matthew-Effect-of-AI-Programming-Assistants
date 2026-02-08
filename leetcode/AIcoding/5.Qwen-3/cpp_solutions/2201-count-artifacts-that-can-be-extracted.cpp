#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countArtifacts(int n, vector<vector<int>>& artifacts, vector<vector<int>>& queries) {
        vector<vector<int>> grid(n, vector<int>(n, 0));

        for (const auto& a : artifacts) {
            int x1 = a[0], y1 = a[1], x2 = a[2], y2 = a[3];
            for (int i = x1; i <= x2; ++i) {
                for (int j = y1; j <= y2; ++j) {
                    grid[i][j]++;
                }
            }
        }

        int count = 0;
        for (const auto& q : queries) {
            int x = q[0], y = q[1];
            if (grid[x][y] > 0) {
                ++count;
            }
        }

        return count;
    }
};