#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minNumberOfSemesters(int n, vector<vector<int>>& dependencies, int k) {
        vector<int> indegree(n, 0);
        vector<vector<int>> adj(n);
        for (auto& dep : dependencies) {
            adj[dep[0] - 1].push_back(dep[1] - 1);
            indegree[dep[1] - 1]++;
        }

        int preMask[n];
        for (int i = 0; i < n; ++i) {
            preMask[i] = 0;
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < adj[i].size(); ++j) {
                preMask[adj[i][j]] |= (1 << i);
            }
        }

        int dp[1 << n];
        for (int i = 0; i < (1 << n); ++i) {
            dp[i] = n + 1;
        }
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (dp[mask] == n + 1) continue;

            vector<int> possibleCourses;
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i)) && (preMask[i] & mask) == preMask[i]) {
                    possibleCourses.push_back(i);
                }
            }

            int m = possibleCourses.size();
            for (int submask = 0; submask < (1 << m); ++submask) {
                if (__builtin_popcount(submask) > k || __builtin_popcount(submask) == 0) continue;

                int nextMask = mask;
                for (int i = 0; i < m; ++i) {
                    if (submask & (1 << i)) {
                        nextMask |= (1 << possibleCourses[i]);
                    }
                }
                dp[nextMask] = min(dp[nextMask], dp[mask] + 1);
            }
        }

        return dp[(1 << n) - 1];
    }
};