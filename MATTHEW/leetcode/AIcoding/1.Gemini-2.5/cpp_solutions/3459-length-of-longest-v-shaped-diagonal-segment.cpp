#include <vector>
#include <algorithm>

class Solution {
public:
    int longestVShapedSegment(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) {
            return 0;
        }
        int n = grid[0].size();
        if (n == 0) {
            return 0;
        }

        std::vector<std::vector<int>> dl(m, std::vector<int>(n, 0));
        std::vector<std::vector<int>> dr(m, std::vector<int>(n, 0));
        int maxLength = 0;

        for (int i = m - 1; i >= 0; --i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    dr[i][j] = 1 + (i + 1 < m && j + 1 < n ? dr[i + 1][j + 1] : 0);
                    dl[i][j] = 1 + (i + 1 < m && j - 1 >= 0 ? dl[i + 1][j - 1] : 0);

                    int len = std::min(dl[i][j], dr[i][j]);
                    if (len > 1) {
                        maxLength = std::max(maxLength, len);
                    }
                }
            }
        }

        return maxLength;
    }
};