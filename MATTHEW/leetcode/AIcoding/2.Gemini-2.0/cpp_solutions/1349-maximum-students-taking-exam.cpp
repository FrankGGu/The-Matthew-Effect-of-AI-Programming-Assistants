#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxStudents(vector<vector<char>>& seats) {
        int m = seats.size();
        int n = seats[0].size();
        vector<int> validRows(m, 0);
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (seats[i][j] == '.') {
                    validRows[i] |= (1 << j);
                }
            }
        }

        vector<int> dp(1 << n, -1);
        dp[0] = 0;

        for (int i = 0; i < m; ++i) {
            vector<int> nextDp(1 << n, -1);
            for (int mask = 0; mask < (1 << n); ++mask) {
                if (dp[mask] == -1) continue;

                for (int nextMask = 0; nextMask < (1 << n); ++nextMask) {
                    if ((nextMask & validRows[i]) != nextMask) continue;

                    bool valid = true;
                    for (int j = 0; j < n; ++j) {
                        if ((nextMask & (1 << j)) != 0) {
                            if ((j > 0 && (nextMask & (1 << (j - 1))) != 0) ||
                                (j < n - 1 && (nextMask & (1 << (j + 1))) != 0)) {
                                valid = false;
                                break;
                            }
                            if (i > 0) {
                                if ((j > 0 && (mask & (1 << (j - 1))) != 0) ||
                                    (j < n - 1 && (mask & (1 << (j + 1))) != 0)) {
                                    valid = false;
                                    break;
                                }
                            }
                        }
                    }

                    if (valid) {
                        int count = __builtin_popcount(nextMask);
                        nextDp[nextMask] = max(nextDp[nextMask], dp[mask] + count);
                    }
                }
            }
            dp = nextDp;
        }

        int ans = 0;
        for (int mask = 0; mask < (1 << n); ++mask) {
            ans = max(ans, dp[mask]);
        }

        return ans;
    }
};