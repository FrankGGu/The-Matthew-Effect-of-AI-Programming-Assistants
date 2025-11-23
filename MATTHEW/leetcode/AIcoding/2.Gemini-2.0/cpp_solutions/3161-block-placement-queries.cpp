#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> canPlaceBlocks(int n, vector<vector<int>>& coordinates) {
        vector<bool> res(coordinates.size());
        vector<vector<int>> grid(n, vector<int>(n, 0));

        for (int i = 0; i < coordinates.size(); ++i) {
            int r = coordinates[i][0];
            int c = coordinates[i][1];
            int len = coordinates[i][2];

            bool canPlace = true;
            for (int k = c; k < c + len; ++k) {
                if (grid[r][k] == 1) {
                    canPlace = false;
                    break;
                }
            }

            if (canPlace) {
                for (int k = c; k < c + len; ++k) {
                    grid[r][k] = 1;
                }
            }

            res[i] = canPlace;
        }

        return res;
    }
};