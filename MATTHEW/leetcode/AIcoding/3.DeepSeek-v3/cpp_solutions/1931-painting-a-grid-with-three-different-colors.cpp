class Solution {
public:
    int colorTheGrid(int m, int n) {
        const int MOD = 1e9 + 7;
        vector<int> validStates;

        auto generate = [&](auto&& self, int pos, int prev, int state) {
            if (pos == m) {
                validStates.push_back(state);
                return;
            }
            for (int c = 0; c < 3; ++c) {
                if (c != prev) {
                    self(self, pos + 1, c, state * 3 + c);
                }
            }
        };

        generate(generate, 0, -1, 0);

        int k = validStates.size();
        vector<vector<int>> transition(k);
        for (int i = 0; i < k; ++i) {
            for (int j = 0; j < k; ++j) {
                bool compatible = true;
                int s1 = validStates[i], s2 = validStates[j];
                for (int p = 0; p < m; ++p) {
                    if ((s1 % 3) == (s2 % 3)) {
                        compatible = false;
                        break;
                    }
                    s1 /= 3;
                    s2 /= 3;
                }
                if (compatible) {
                    transition[i].push_back(j);
                }
            }
        }

        vector<int> dp(k, 1);
        for (int i = 1; i < n; ++i) {
            vector<int> newDp(k, 0);
            for (int j = 0; j < k; ++j) {
                for (int neighbor : transition[j]) {
                    newDp[j] = (newDp[j] + dp[neighbor]) % MOD;
                }
            }
            dp = move(newDp);
        }

        int res = 0;
        for (int num : dp) {
            res = (res + num) % MOD;
        }
        return res;
    }
};