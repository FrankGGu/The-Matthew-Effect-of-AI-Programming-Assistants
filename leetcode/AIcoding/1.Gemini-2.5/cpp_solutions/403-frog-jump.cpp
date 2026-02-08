#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool canCross(vector<int>& stones) {
        int n = stones.size();
        vector<unordered_set<int>> dp(n);
        dp[0].insert(0);

        for (int i = 0; i < n; ++i) {
            for (int k : dp[i]) {
                for (int step = k - 1; step <= k + 1; ++step) {
                    if (step > 0) {
                        for (int j = i + 1; j < n; ++j) {
                            if (stones[j] == stones[i] + step) {
                                dp[j].insert(step);
                            }
                        }
                    }
                }
            }
        }

        return !dp[n - 1].empty();
    }
};