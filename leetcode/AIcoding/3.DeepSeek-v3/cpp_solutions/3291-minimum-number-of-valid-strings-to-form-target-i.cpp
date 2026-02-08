#include <vector>
#include <string>
#include <climits>

using namespace std;

class Solution {
public:
    int minStickers(vector<string>& stickers, string target) {
        int n = target.size();
        vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;

        for (int state = 0; state < (1 << n); ++state) {
            if (dp[state] == INT_MAX) continue;

            for (const string& sticker : stickers) {
                int new_state = state;
                for (char c : sticker) {
                    for (int i = 0; i < n; ++i) {
                        if (!(new_state & (1 << i)) && target[i] == c) {
                            new_state |= (1 << i);
                            break;
                        }
                    }
                }
                if (dp[new_state] > dp[state] + 1) {
                    dp[new_state] = dp[state] + 1;
                }
            }
        }

        return dp[(1 << n) - 1] == INT_MAX ? -1 : dp[(1 << n) - 1];
    }
};