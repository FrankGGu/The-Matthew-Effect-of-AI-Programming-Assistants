class Solution {
public:
    int minNumberOfSemesters(int n, vector<vector<int>>& relations, int k) {
        vector<vector<int>> graph(n + 1);
        vector<int> indegree(n + 1, 0);
        vector<int> dp(1 << n, INT_MAX);

        for (auto& relation : relations) {
            graph[relation[0]].push_back(relation[1]);
            indegree[relation[1]]++;
        }

        dp[0] = 0;
        for (int mask = 0; mask < (1 << n); ++mask) {
            vector<int> available;
            for (int i = 1; i <= n; ++i) {
                if ((mask & (1 << (i - 1))) == 0 && indegree[i] == 0) {
                    available.push_back(i);
                }
            }

            int m = available.size();
            for (int i = 1; i <= min(k, m); ++i) {
                vector<int> comb(m);
                iota(comb.begin(), comb.end(), 0);
                do {
                    int new_mask = mask;
                    for (int j = 0; j < i; ++j) {
                        new_mask |= (1 << (available[comb[j]] - 1));
                    }
                    for (int j = 0; j < i; ++j) {
                        for (int next : graph[available[comb[j]]]) {
                            indegree[next]--;
                        }
                    }
                    dp[new_mask] = min(dp[new_mask], dp[mask] + 1);
                    for (int j = 0; j < i; ++j) {
                        for (int next : graph[available[comb[j]]]) {
                            indegree[next]++;
                        }
                    }
                } while (next_permutation(comb.begin(), comb.begin() + i));
            }
        }

        return dp[(1 << n) - 1];
    }
};