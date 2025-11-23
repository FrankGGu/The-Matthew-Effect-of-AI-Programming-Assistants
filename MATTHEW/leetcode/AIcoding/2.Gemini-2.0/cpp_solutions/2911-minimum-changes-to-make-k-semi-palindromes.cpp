#include <vector>
#include <string>
#include <algorithm>

using namespace std;

int minChanges(const string& s) {
    int n = s.length();
    int changes = 0;
    for (int i = 0, j = n - 1; i < j; ++i, --j) {
        if (s[i] != s[j]) {
            ++changes;
        }
    }
    return changes;
}

int solve(int index, int k, const string& s, vector<vector<int>>& dp, vector<vector<vector<int>>>& cost) {
    int n = s.length();
    if (index == n) {
        return k == 0 ? 0 : 1e9;
    }

    if (k == 0) {
        return 1e9;
    }

    if (dp[index][k] != -1) {
        return dp[index][k];
    }

    int ans = 1e9;
    for (int i = index; i < n; ++i) {
        ans = min(ans, cost[index][i][0] + solve(i + 1, k - 1, s, dp, cost));

    }

    return dp[index][k] = ans;
}

int get_cost(int l, int r, const string& s, vector<vector<int>>& dp) {
    if (l >= r) return 0;
    if (dp[l][r] != -1) return dp[l][r];

    if (s[l] == s[r]) return dp[l][r] = get_cost(l+1, r-1, s, dp);
    else return dp[l][r] = 1 + get_cost(l+1, r-1, s, dp);
}

int kSemiPalindromes(string s, int k) {
    int n = s.length();
    vector<vector<int>> dp(n, vector<int>(k + 1, -1));

    vector<vector<vector<int>>> cost(n, vector<vector<int>>(n, vector<int>(1, 0)));

    for(int i = 0; i < n; ++i) {
        for(int j = i; j < n; ++j) {
            vector<vector<int>> temp(j - i + 1, vector<int>(j - i + 1, -1));
            cost[i][j][0] = get_cost(i, j, s, temp);
        }
    }

    return solve(0, k, s, dp, cost);
}