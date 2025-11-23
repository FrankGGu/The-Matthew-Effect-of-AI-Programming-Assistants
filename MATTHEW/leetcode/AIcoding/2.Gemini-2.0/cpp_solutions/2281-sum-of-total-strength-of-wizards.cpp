#include <vector>

using namespace std;

class Solution {
public:
    int sumOfTotalStrength(vector<int>& strength) {
        int n = strength.size();
        long long MOD = 1e9 + 7;

        vector<long long> left(n);
        vector<long long> right(n);

        vector<int> stack;
        for (int i = 0; i < n; ++i) {
            while (!stack.empty() && strength[stack.back()] >= strength[i]) {
                stack.pop_back();
            }
            left[i] = stack.empty() ? -1 : stack.back();
            stack.push_back(i);
        }

        stack.clear();
        for (int i = n - 1; i >= 0; --i) {
            while (!stack.empty() && strength[stack.back()] > strength[i]) {
                stack.pop_back();
            }
            right[i] = stack.empty() ? n : stack.back();
            stack.push_back(i);
        }

        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
        }

        vector<long long> prefixSum2(n + 2, 0);
        for (int i = 0; i <= n; ++i) {
            prefixSum2[i + 1] = (prefixSum2[i] + prefixSum[i]) % MOD;
        }

        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            long long l = left[i];
            long long r = right[i];
            long long leftLen = i - l;
            long long rightLen = r - i;

            long long leftSum = (prefixSum2[i + 1] - prefixSum2[max(0LL, (long long)i - leftLen + 1)] + MOD) % MOD;
            leftSum = (leftSum * rightLen) % MOD;

            long long rightSum = (prefixSum2[min((long long)n + 1, (long long)i + rightLen + 1)] - prefixSum2[i + 1] + MOD) % MOD;
            rightSum = (rightSum * leftLen) % MOD;

            long long totalSum = (leftSum + rightSum - (long long)strength[i] * leftLen % MOD * rightLen % MOD + MOD) % MOD;

            ans = (ans + (long long)strength[i] * totalSum % MOD) % MOD;
        }

        return ans;
    }
};