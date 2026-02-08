#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSwapsToArrangeBinaryGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> rowHeights(n, 0);

        for (int i = 0; i < n; ++i) {
            int height = 0;
            for (int j = n - 1; j >= 0; --j) {
                if (grid[i][j] == 1) {
                    height = n - j;
                    break;
                }
            }
            rowHeights[i] = height;
        }

        int swaps = 0;
        for (int i = 0; i < n; ++i) {
            int target = n - i;
            int j = i;
            while (j < n && rowHeights[j] < target) {
                ++j;
            }
            if (j == n) return -1;
            while (j > i) {
                swap(rowHeights[j], rowHeights[j - 1]);
                ++swaps;
                --j;
            }
        }
        return swaps;
    }
};