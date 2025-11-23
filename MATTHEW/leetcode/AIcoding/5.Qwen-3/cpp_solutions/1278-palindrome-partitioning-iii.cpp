#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int dp[16][16];
    int minPartitions(string s, int k) {
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                dp[i][j] = 0;
                int l = i, r = j;
                while (l < r) {
                    if (s[l] != s[r]) {
                        dp[i][j]++;
                    }
                    l++;
                    r--;
                }
            }
        }
        vector<vector<int>> memo(n, vector<int>(k + 1, -1));
        function<int(int, int)> dfs = [&](int idx, int cnt) {
            if (idx == n) {
                return cnt == k ? 0 : 1e9;
            }
            if (cnt > k) {
                return 1e9;
            }
            if (memo[idx][cnt] != -1) {
                return memo[idx][cnt];
            }
            int res = 1e9;
            for (int i = idx; i < n; ++i) {
                int cost = dp[idx][i];
                res = min(res, cost + dfs(i + 1, cnt + 1));
            }
            return memo[idx][cnt] = res;
        };
        return dfs(0, 0);
    }
};