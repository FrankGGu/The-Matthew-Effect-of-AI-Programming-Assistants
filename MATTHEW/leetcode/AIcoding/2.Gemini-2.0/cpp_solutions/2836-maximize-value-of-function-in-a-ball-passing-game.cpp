#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long getMaxFunctionValue(vector<int>& receiver, long long k) {
        int n = receiver.size();
        int log_k = 0;
        long long temp_k = k;
        while (temp_k > 0) {
            log_k++;
            temp_k >>= 1;
        }

        vector<vector<int>> jump(log_k, vector<int>(n));
        vector<vector<long long>> sum(log_k, vector<long long>(n));

        for (int i = 0; i < n; ++i) {
            jump[0][i] = receiver[i];
            sum[0][i] = receiver[i];
        }

        for (int i = 1; i < log_k; ++i) {
            for (int j = 0; j < n; ++j) {
                jump[i][j] = jump[i - 1][jump[i - 1][j]];
                sum[i][j] = sum[i - 1][j] + sum[i - 1][jump[i - 1][j]];
            }
        }

        long long max_val = 0;
        for (int start = 0; start < n; ++start) {
            long long current_sum = start;
            int current_node = start;

            for (int i = log_k - 1; i >= 0; --i) {
                if ((k >> i) & 1) {
                    current_sum += sum[i][current_node];
                    current_node = jump[i][current_node];
                }
            }
            max_val = max(max_val, current_sum);
        }

        return max_val;
    }
};