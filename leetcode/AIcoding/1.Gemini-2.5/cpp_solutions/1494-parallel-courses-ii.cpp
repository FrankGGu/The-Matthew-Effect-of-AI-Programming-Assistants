#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int minNumberOfSemesters(int n, std::vector<std::vector<int>>& relations, int k) {
        std::vector<int> prereq(n, 0);
        for (const auto& rel : relations) {
            int u = rel[0] - 1;
            int v = rel[1] - 1;
            prereq[v] |= (1 << u);
        }

        std::vector<int> dp(1 << n, n + 1);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (dp[mask] == n + 1) {
                continue;
            }

            int available_courses_mask = 0;
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i)) && (mask & prereq[i]) == prereq[i]) {
                    available_courses_mask |= (1 << i);
                }
            }

            int num_available = __builtin_popcount(available_courses_mask);

            if (num_available <= k) {
                int next_mask = mask | available_courses_mask;
                dp[next_mask] = std::min(dp[next_mask], dp[mask] + 1);
            } else {
                for (int submask = available_courses_mask; submask > 0; submask = (submask - 1) & available_courses_mask) {
                    if (__builtin_popcount(submask) == k) {
                        int next_mask = mask | submask;
                        dp[next_mask] = std::min(dp[next_mask], dp[mask] + 1);
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};