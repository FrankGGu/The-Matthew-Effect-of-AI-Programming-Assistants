#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxHammerHits(vector<int>& moles) {
        int n = moles.size();
        if (n == 0) return 0;
        sort(moles.begin(), moles.end());
        vector<int> dp(n, 1);
        int max_hits = 1;
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (moles[i] % moles[j] == 0) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
            max_hits = max(max_hits, dp[i]);
        }
        return max_hits;
    }
};