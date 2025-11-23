#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool canCross(vector<int>& stones) {
        int n = stones.size();
        unordered_set<int> stoneSet(stones.begin(), stones.end());
        vector<vector<bool>> dp(n, vector<bool>(n + 1, false));
        dp[0][1] = true;

        for (int i = 0; i < n; ++i) {
            for (int k = 1; k <= n; ++k) {
                if (dp[i][k]) {
                    for (int jump = k - 1; jump <= k + 1; ++jump) {
                        if (jump > 0) {
                            int nextStone = stones[i] + jump;
                            if (stoneSet.count(nextStone)) {
                                int nextIndex = -1;
                                for (int j = i + 1; j < n; ++j) {
                                    if (stones[j] == nextStone) {
                                        nextIndex = j;
                                        break;
                                    }
                                }
                                if (nextIndex != -1) {
                                    dp[nextIndex][jump] = true;
                                }
                            }
                        }
                    }
                }
            }
        }

        for (int k = 1; k <= n; ++k) {
            if (dp[n - 1][k]) {
                return true;
            }
        }

        return false;
    }
};