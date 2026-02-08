#include <vector>

using namespace std;

const int MOD = 1e9 + 7;

class Solution {
public:
    int countWays(int n) {
        vector<long long> three(n + 1);
        vector<long long> four(n + 1);
        vector<long long> total(n + 1);

        three[1] = 1;
        four[1] = 1;
        total[1] = 2;

        for (int i = 2; i <= n; ++i) {
            three[i] = (total[i - 1] + four[i - 1]) % MOD;
            four[i] = (total[i - 1] + three[i - 1]) % MOD;
            total[i] = (three[i] + four[i]) % MOD;
        }

        long long ans = 1;
        for (int i = 0; i < n; ++i) {
            ans = (ans * total[n]) % MOD;
        }

        return ans;
    }
};