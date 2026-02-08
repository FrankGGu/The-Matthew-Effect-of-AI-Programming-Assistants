#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumOperations(std::string leaves) {
        int n = leaves.size();

        int dp0 = (leaves[0] == 'y');
        int dp1 = n + 1;
        int dp2 = n + 1;

        for (int i = 1; i < n; ++i) {
            int is_y = (leaves[i] == 'y');
            int is_r = (leaves[i] == 'r');

            if (i >= 2) {
                dp2 = std::min(dp1, dp2) + is_y;
            }
            dp1 = std::min(dp0, dp1) + is_r;
            dp0 = dp0 + is_y;
        }

        return dp2;
    }
};