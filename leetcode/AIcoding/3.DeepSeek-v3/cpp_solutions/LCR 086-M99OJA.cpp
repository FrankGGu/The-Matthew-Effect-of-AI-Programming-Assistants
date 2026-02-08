#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<vector<string>> partition(string s) {
        int n = s.size();
        vector<vector<bool>> dp(n, vector<bool>(n, false));
        for (int i = n - 1; i >= 0; --i) {
            for (int j = i; j < n; ++j) {
                if (s[i] == s[j] && (j - i <= 2 || dp[i+1][j-1])) {
                    dp[i][j] = true;
                }
            }
        }

        vector<vector<string>> res;
        vector<string> path;
        dfs(s, 0, dp, path, res);
        return res;
    }

private:
    void dfs(const string& s, int start, vector<vector<bool>>& dp, vector<string>& path, vector<vector<string>>& res) {
        if (start == s.size()) {
            res.push_back(path);
            return;
        }

        for (int end = start; end < s.size(); ++end) {
            if (dp[start][end]) {
                path.push_back(s.substr(start, end - start + 1));
                dfs(s, end + 1, dp, path, res);
                path.pop_back();
            }
        }
    }
};