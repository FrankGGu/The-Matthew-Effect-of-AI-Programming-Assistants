class Solution {
public:
    string shortestSuperstring(vector<string>& A) {
        int n = A.size();
        vector<vector<int>> graph(n, vector<int>(n));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    graph[i][j] = calcOverlap(A[i], A[j]);
                }
            }
        }

        vector<vector<int>> dp(1 << n, vector<int>(n, INT_MAX));
        vector<vector<int>> path(1 << n, vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = A[i].length();
        }

        for (int mask = 1; mask < (1 << n); ++mask) {
            for (int last = 0; last < n; ++last) {
                if (!(mask & (1 << last))) continue;
                int prev_mask = mask ^ (1 << last);
                if (prev_mask == 0) continue;
                for (int k = 0; k < n; ++k) {
                    if (prev_mask & (1 << k)) {
                        if (dp[prev_mask][k] + graph[k][last] < dp[mask][last]) {
                            dp[mask][last] = dp[prev_mask][k] + graph[k][last];
                            path[mask][last] = k;
                        }
                    }
                }
            }
        }

        int last = min_element(dp.back().begin(), dp.back().end()) - dp.back().begin();
        int mask = (1 << n) - 1;
        vector<int> order;

        while (mask) {
            order.push_back(last);
            int temp = mask;
            mask ^= (1 << last);
            last = path[temp][last];
        }

        reverse(order.begin(), order.end());
        string res = A[order[0]];

        for (int i = 1; i < order.size(); ++i) {
            int overlap = graph[order[i-1]][order[i]];
            res += A[order[i]].substr(overlap);
        }

        return res;
    }

private:
    int calcOverlap(const string& a, const string& b) {
        int max_len = min(a.length(), b.length());
        for (int l = max_len; l >= 1; --l) {
            if (a.substr(a.length() - l) == b.substr(0, l)) {
                return b.length() - l;
            }
        }
        return b.length();
    }
};