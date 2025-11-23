#include <vector>
#include <algorithm>

class Solution {
public:
    int jewelleryValue(std::vector<std::vector<int>>& frame) {
        if (frame.empty() || frame[0].empty()) {
            return 0;
        }
        int m = frame.size();
        int n = frame[0].size();
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) {
                    continue;
                }
                if (i == 0) {
                    frame[i][j] += frame[i][j - 1];
                } else if (j == 0) {
                    frame[i][j] += frame[i - 1][j];
                } else {
                    frame[i][j] += std::max(frame[i - 1][j], frame[i][j - 1]);
                }
            }
        }
        return frame[m - 1][n - 1];
    }
};