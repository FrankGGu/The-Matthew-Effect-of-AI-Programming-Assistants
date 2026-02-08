#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool checkValidString(string s) {
        int n = s.size();
        vector<vector<int>> dp(n, vector<int>(n, -1));

        function<bool(int, int)> dfs = [&](int left, int right) {
            if (left > right) return true;
            if (dp[left][right] != -1) return dp[left][right];

            if (s[left] == '(' && s[right] == ')') {
                dp[left][right] = dfs(left + 1, right - 1);
            } else if (s[left] == '(' && s[right] == '*') {
                dp[left][right] = dfs(left + 1, right - 1) || dfs(left + 1, right) || dfs(left, right - 1);
            } else if (s[left] == '*' && s[right] == ')') {
                dp[left][right] = dfs(left + 1, right - 1) || dfs(left + 1, right) || dfs(left, right - 1);
            } else if (s[left] == '*' && s[right] == '*') {
                dp[left][right] = dfs(left + 1, right - 1) || dfs(left + 1, right) || dfs(left, right - 1);
            } else {
                dp[left][right] = 0;
            }

            return dp[left][right];
        };

        return dfs(0, n - 1);
    }
};