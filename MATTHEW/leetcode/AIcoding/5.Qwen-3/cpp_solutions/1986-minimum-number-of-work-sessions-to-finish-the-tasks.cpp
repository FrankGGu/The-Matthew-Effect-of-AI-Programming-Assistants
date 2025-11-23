#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minSessions(vector<int>& tasks, int sessionTime) {
        int n = tasks.size();
        vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (dp[mask] == INT_MAX) continue;
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) {
                    int new_mask = mask | (1 << i);
                    int remaining = sessionTime - tasks[i];
                    int current_session = 0;
                    for (int j = 0; j < n; ++j) {
                        if (mask & (1 << j)) {
                            if (remaining >= tasks[j]) {
                                remaining -= tasks[j];
                            } else {
                                current_session++;
                                remaining = sessionTime - tasks[j];
                            }
                        }
                    }
                    dp[new_mask] = min(dp[new_mask], dp[mask] + current_session + (remaining < 0 ? 1 : 0));
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};