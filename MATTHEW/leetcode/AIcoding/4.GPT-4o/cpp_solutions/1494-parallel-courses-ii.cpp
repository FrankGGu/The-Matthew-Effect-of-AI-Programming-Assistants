class Solution {
public:
    int minNumberOfSemesters(int n, vector<vector<int>>& relations, int k) {
        vector<vector<int>> graph(n);
        vector<int> indegree(n, 0);

        for (auto& relation : relations) {
            graph[relation[0] - 1].push_back(relation[1] - 1);
            indegree[relation[1] - 1]++;
        }

        vector<vector<int>> dp(1 << n, vector<int>(n + 1, INT_MAX));
        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int count = __builtin_popcount(mask);
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i)) && indegree[i] == 0) {
                    int nextMask = mask | (1 << i);
                    int nextCount = __builtin_popcount(nextMask);
                    dp[nextMask][nextCount] = min(dp[nextMask][nextCount], dp[mask][count] + 1);
                    for (int neighbor : graph[i]) {
                        indegree[neighbor]--;
                    }
                }
            }
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    for (int neighbor : graph[i]) {
                        indegree[neighbor]++;
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int i = 1; i <= n; ++i) {
            if (dp[(1 << n) - 1][i] != INT_MAX) {
                result = min(result, dp[(1 << n) - 1][i]);
            }
        }

        return result;
    }
};