#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxSlices(int n, std::vector<int>& slices) {
        int k = slices.size() / 3;
        std::vector<int> dp(n + 1, 0);
        for (int slice : slices) {
            for (int j = n; j >= slice; --j) {
                dp[j] = std::max(dp[j], dp[j - slice] + slice);
            }
        }
        return dp[n];
    }
};