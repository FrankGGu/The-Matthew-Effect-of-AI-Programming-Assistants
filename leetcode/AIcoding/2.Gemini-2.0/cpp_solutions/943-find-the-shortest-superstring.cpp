#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string shortestSuperstring(vector<string>& A) {
        int n = A.size();
        vector<vector<int>> overlap(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                int m = min(A[i].size(), A[j].size());
                for (int k = m; k > 0; --k) {
                    if (A[i].substr(A[i].size() - k) == A[j].substr(0, k)) {
                        overlap[i][j] = k;
                        break;
                    }
                }
            }
        }

        vector<vector<string>> dp(1 << n, vector<string>(n, ""));
        vector<vector<int>> parent(1 << n, vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = A[i];
        }

        for (int mask = 1; mask < (1 << n); ++mask) {
            for (int j = 0; j < n; ++j) {
                if (!(mask & (1 << j))) continue;
                for (int k = 0; k < n; ++k) {
                    if (j == k || !(mask & (1 << k))) continue;
                    int prevMask = mask ^ (1 << j);
                    string candidate = dp[prevMask][k] + A[j].substr(overlap[k][j]);
                    if (dp[mask][j] == "" || candidate.size() < dp[mask][j].size()) {
                        dp[mask][j] = candidate;
                        parent[mask][j] = k;
                    }
                }
            }
        }

        string ans = "";
        int last = -1;
        int mask = (1 << n) - 1;
        for (int i = 0; i < n; ++i) {
            if (ans == "" || dp[mask][i].size() < ans.size()) {
                ans = dp[mask][i];
                last = i;
            }
        }

        string res = "";
        while (last != -1) {
            int prev = parent[mask][last];
            res = dp[mask][last];
            mask ^= (1 << last);
            last = prev;
        }

        return res;
    }
};