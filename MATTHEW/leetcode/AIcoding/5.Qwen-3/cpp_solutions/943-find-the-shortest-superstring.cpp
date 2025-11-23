#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findShortestSuperstring(vector<string>& words) {
        int n = words.size();
        vector<vector<int>> cost(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    int len = 0;
                    int minLen = min(words[i].size(), words[j].size());
                    while (len < minLen && words[i][words[i].size() - 1 - len] == words[j][len]) {
                        ++len;
                    }
                    cost[i][j] = len;
                }
            }
        }

        vector<vector<int>> dp(n, vector<int>(1 << n, 0));
        vector<vector<int>> prev(n, vector<int>(1 << n, -1));

        for (int i = 0; i < n; ++i) {
            dp[i][1 << i] = words[i].size();
        }

        for (int mask = 1; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if ((mask & (1 << i)) == 0) continue;
                for (int j = 0; j < n; ++j) {
                    if ((mask & (1 << j)) || i == j) continue;
                    int new_mask = mask | (1 << j);
                    int new_cost = dp[i][mask] + words[j].size() - cost[i][j];
                    if (dp[j][new_mask] < new_cost) {
                        dp[j][new_mask] = new_cost;
                        prev[j][new_mask] = i;
                    }
                }
            }
        }

        int last = -1, best = 0;
        for (int i = 0; i < n; ++i) {
            if (dp[i][(1 << n) - 1] > best) {
                best = dp[i][(1 << n) - 1];
                last = i;
            }
        }

        vector<int> path;
        int mask = (1 << n) - 1;
        while (last != -1) {
            path.push_back(last);
            int tmp = last;
            last = prev[tmp][mask];
            mask ^= (1 << tmp);
        }

        reverse(path.begin(), path.end());
        string res = words[path[0]];
        for (int i = 1; i < path.size(); ++i) {
            res += words[path[i]].substr(cost[path[i-1]][path[i]]);
        }

        return res;
    }
};