#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include <climits>

using namespace std;

class Solution {
public:
    int minNumberOfSemesters(int n, vector<vector<int>>& dependencies, int k) {
        vector<vector<int>> graph(n);
        vector<int> in_degree(n, 0);
        for (auto& dep : dependencies) {
            int prerequisite = dep[0] - 1;
            int course = dep[1] - 1;
            graph[prerequisite].push_back(course);
            in_degree[course]++;
        }

        vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (dp[mask] == INT_MAX) continue;

            vector<int> available;
            for (int i = 0; i < n; ++i) {
                if ((mask & (1 << i)) == 0 && in_degree[i] == 0) {
                    available.push_back(i);
                }
            }

            int m = available.size();
            int max_courses = min(k, m);
            int total = 0;
            for (int i = 0; i < (1 << m); ++i) {
                int cnt = __builtin_popcount(i);
                if (cnt > max_courses) continue;
                int new_mask = mask;
                for (int j = 0; j < m; ++j) {
                    if (i & (1 << j)) {
                        new_mask |= (1 << available[j]);
                    }
                }
                dp[new_mask] = min(dp[new_mask], dp[mask] + 1);
            }
        }

        return dp[(1 << n) - 1];
    }
};