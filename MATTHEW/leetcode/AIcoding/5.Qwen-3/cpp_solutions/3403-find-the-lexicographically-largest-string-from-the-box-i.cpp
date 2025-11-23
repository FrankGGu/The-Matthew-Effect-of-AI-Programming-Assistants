#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string removeBoxes(vector<int>& boxes) {
        int n = boxes.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n + 1, 0)));

        function<int(int, int, int)> dfs = [&](int l, int r, int k) -> int {
            if (l > r) return 0;
            if (dp[l][r][k] != 0) return dp[l][r][k];

            int res = dfs(l + 1, r, 0) + (k + 1) * (boxes[l] == boxes[l + 1] ? 1 : 0);
            for (int i = l + 1; i <= r; ++i) {
                if (boxes[i] == boxes[l]) {
                    res = max(res, dfs(l + 1, i - 1, 0) + dfs(i, r, k + 1));
                }
            }
            return dp[l][r][k] = res;
        };

        return to_string(dfs(0, n - 1, 0));
    }
};