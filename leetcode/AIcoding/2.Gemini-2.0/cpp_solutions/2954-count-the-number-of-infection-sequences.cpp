#include <vector>

using namespace std;

class Solution {
public:
    int numberOfSequence(int n, vector<int>& sick) {
        int m = sick.size();
        long long MOD = 1e9 + 7;
        sort(sick.begin(), sick.end());
        long long ans = 1;
        long long healthyLeft = sick[0];
        long long healthyRight = n - sick[m - 1] - 1;
        for (int i = 0; i < healthyLeft; ++i) {
            ans = (ans * 2) % MOD;
        }
        for (int i = 0; i < healthyRight; ++i) {
            ans = (ans * 2) % MOD;
        }
        long long totalHealthy = n - m;
        long long factorialTotalHealthy = 1;
        for (int i = 1; i <= totalHealthy; ++i) {
            factorialTotalHealthy = (factorialTotalHealthy * i) % MOD;
        }
        ans = (ans * factorialTotalHealthy) % MOD;
        for (int i = 0; i < m - 1; ++i) {
            long long healthyBetween = sick[i + 1] - sick[i] - 1;
            for (int j = 0; j < healthyBetween; ++j) {
                ans = (ans * (healthyBetween - j)) % MOD;
                long long inv = power(j + 2, MOD - 2, MOD);
                ans = (ans * inv) % MOD;
            }
        }
        return ans;
    }

private:
    long long power(long long base, long long exp, long long mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
};