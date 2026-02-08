#include <vector>

using namespace std;

class Solution {
public:
    int numSubmat(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        vector<vector<int>> height(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (mat[i][j] == 1) {
                    height[i][j] = (i == 0) ? 1 : height[i - 1][j] + 1;
                }
            }
        }

        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int minHeight = height[i][j];
                for (int k = j; k >= 0; --k) {
                    minHeight = min(minHeight, height[i][k]);
                    count += minHeight;
                    if (height[i][k] == 0) break;
                }
            }
        }

        return count;
    }
};