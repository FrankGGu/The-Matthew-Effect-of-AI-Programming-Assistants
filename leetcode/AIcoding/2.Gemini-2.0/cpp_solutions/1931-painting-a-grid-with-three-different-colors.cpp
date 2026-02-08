#include <vector>

using namespace std;

class Solution {
public:
    int colorTheGrid(int m, int n) {
        int MOD = 1e9 + 7;
        vector<int> valid_states;
        for (int i = 0; i < pow(3, m); ++i) {
            int temp = i;
            bool valid = true;
            vector<int> colors(m);
            for (int j = m - 1; j >= 0; --j) {
                colors[j] = temp % 3;
                temp /= 3;
            }
            for (int j = 0; j < m - 1; ++j) {
                if (colors[j] == colors[j + 1]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                valid_states.push_back(i);
            }
        }

        int num_states = valid_states.size();
        vector<vector<long long>> adj_matrix(num_states, vector<long long>(num_states, 0));
        for (int i = 0; i < num_states; ++i) {
            for (int j = 0; j < num_states; ++j) {
                int state1 = valid_states[i];
                int state2 = valid_states[j];
                bool compatible = true;
                vector<int> colors1(m);
                vector<int> colors2(m);
                int temp1 = state1;
                int temp2 = state2;
                for (int k = m - 1; k >= 0; --k) {
                    colors1[k] = temp1 % 3;
                    temp1 /= 3;
                    colors2[k] = temp2 % 3;
                    temp2 /= 3;
                }
                for (int k = 0; k < m; ++k) {
                    if (colors1[k] == colors2[k]) {
                        compatible = false;
                        break;
                    }
                }
                if (compatible) {
                    adj_matrix[i][j] = 1;
                }
            }
        }

        vector<long long> dp(num_states, 1);
        for (int i = 1; i < n; ++i) {
            vector<long long> new_dp(num_states, 0);
            for (int j = 0; j < num_states; ++j) {
                for (int k = 0; k < num_states; ++k) {
                    if (adj_matrix[j][k] == 1) {
                        new_dp[k] = (new_dp[k] + dp[j]) % MOD;
                    }
                }
            }
            dp = new_dp;
        }

        long long total = 0;
        for (int i = 0; i < num_states; ++i) {
            total = (total + dp[i]) % MOD;
        }

        return total;
    }
};