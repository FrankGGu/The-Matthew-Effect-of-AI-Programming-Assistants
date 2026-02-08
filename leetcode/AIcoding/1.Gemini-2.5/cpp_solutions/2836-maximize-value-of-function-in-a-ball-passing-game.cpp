#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long getMaxFunctionValue(vector<int>& receiver, long long k) {
        int n = receiver.size();
        int logK = 0;
        long long tempK = k;
        while (tempK > 0) {
            logK++;
            tempK >>= 1;
        }

        vector<vector<int>> jump(logK, vector<int>(n));
        vector<vector<long long>> sum(logK, vector<long long>(n));

        for (int i = 0; i < n; i++) {
            jump[0][i] = receiver[i];
            sum[0][i] = receiver[i];
        }

        for (int i = 1; i < logK; i++) {
            for (int j = 0; j < n; j++) {
                jump[i][j] = jump[i - 1][jump[i - 1][j]];
                sum[i][j] = sum[i - 1][j] + sum[i - 1][jump[i - 1][j]];
            }
        }

        long long ans = 0;
        for (int i = 0; i < n; i++) {
            long long currentSum = i;
            int current = i;
            for (int j = logK - 1; j >= 0; j--) {
                if ((k >> j) & 1) {
                    currentSum += sum[j][current];
                    current = jump[j][current];
                }
            }
            ans = max(ans, currentSum);
        }

        return ans;
    }
};