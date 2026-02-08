#include <vector>
#include <cmath> // For std::abs

class Solution {
private:
    static const int MOD = 1000000007;
    static std::vector<long long> fact;
    static std::vector<long long> invFact;
    static bool precomputed;
    static const int MAX_K = 1000;

    static long long power(long long base, long long exp) {
        long long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    static long long inv(long long n) {
        return power(n, MOD - 2);
    }

    static void precompute_factorials() {
        if (precomputed) return;

        fact.resize(MAX_K + 1);
        invFact.resize(MAX_K + 1);

        fact[0] = 1;
        for (int i = 1; i <= MAX_K; ++i) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        invFact[MAX_K] = inv(fact[MAX_K]);
        for (int i = MAX_K - 1; i >= 0; --i) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
        precomputed = true;
    }

    static long long nCr_mod_p(int n, int r) {
        if (r < 0 || r > n) return 0;
        return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
    }

public:
    int numberOfWays(int startPos, int endPos, int k) {
        precompute_factorials();

        int diff = endPos - startPos;

        if (std::abs(diff) > k) {
            return 0;
        }

        if ((k - std::abs(diff)) % 2 != 0) {
            return 0;
        }

        int num_right_steps = (k + diff) / 2;

        return nCr_mod_p(k, num_right_steps);
    }
};

std::vector<long long> Solution::fact;
std::vector<long long> Solution::invFact;
bool Solution::precomputed = false;