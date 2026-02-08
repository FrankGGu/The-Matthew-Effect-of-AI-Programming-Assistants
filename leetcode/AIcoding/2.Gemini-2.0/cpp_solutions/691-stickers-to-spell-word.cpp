#include <vector>
#include <string>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int minStickers(vector<string>& stickers, string target) {
        int n = target.size();
        vector<int> dp(1 << n, -1);
        dp[0] = 0;

        function<int(int)> solve = [&](int mask) {
            if (dp[mask] != -1) {
                return dp[mask];
            }

            dp[mask] = INT_MAX;
            for (string& sticker : stickers) {
                int next_mask = mask;
                vector<int> sticker_counts(26, 0);
                for (char c : sticker) {
                    sticker_counts[c - 'a']++;
                }

                for (int i = 0; i < n; ++i) {
                    if (!(mask & (1 << i))) {
                        char c = target[i];
                        if (sticker_counts[c - 'a'] > 0) {
                            sticker_counts[c - 'a']--;
                            next_mask |= (1 << i);
                        }
                    }
                }

                if (next_mask != mask) {
                    int res = solve(next_mask);
                    if (res != INT_MAX) {
                        dp[mask] = min(dp[mask], res + 1);
                    }
                }
            }
            return dp[mask];
        };

        int result = solve(0);
        return (result == INT_MAX) ? -1 : result;
    }
};