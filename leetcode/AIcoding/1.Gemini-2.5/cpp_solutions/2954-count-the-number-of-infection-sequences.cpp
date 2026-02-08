#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        long long M = 1000000007;
        base %= M;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % M;
            base = (base * base) % M;
            exp /= 2;
        }
        return res;
    }

    long long modInverse(long long n) {
        return power(n, 1000000007 - 2);
    }

    int countInfectionSequences(int n, std::vector<int>& sick) {
        long long M = 1000000007;
        int k = sick.size();
        int m = n - k;

        if (m == 0) {
            return 1;
        }

        std::vector<long long> fact(n + 1);
        std::vector<long long> invFact(n + 1);
        std::vector<long long> pow2(n + 1);

        fact[0] = 1;
        pow2[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % M;
            pow2[i] = (pow2[i - 1] * 2) % M;
        }

        invFact[n] = modInverse(fact[n]);
        for (int i = n - 1; i >= 0; i--) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % M;
        }

        std::sort(sick.begin(), sick.end());

        long long ans = fact[m];

        int first_segment_len = sick[0];
        if (first_segment_len > 0) {
            ans = (ans * invFact[first_segment_len]) % M;
        }

        for (int i = 1; i < k; ++i) {
            int len = sick[i] - sick[i - 1] - 1;
            if (len > 0) {
                ans = (ans * invFact[len]) % M;
                ans = (ans * pow2[len - 1]) % M;
            }
        }

        int last_segment_len = n - 1 - sick.back();
        if (last_segment_len > 0) {
            ans = (ans * invFact[last_segment_len]) % M;
        }

        return ans;
    }
};