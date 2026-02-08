class Solution {
public:
    const int MOD = 1e9 + 7;

    long long modPow(long long a, long long b) {
        long long res = 1;
        while (b > 0) {
            if (b & 1) res = res * a % MOD;
            a = a * a % MOD;
            b >>= 1;
        }
        return res;
    }

    int makeStringSorted(string s) {
        int n = s.size();
        vector<long long> fact(n + 1, 1);
        vector<long long> invFact(n + 1, 1);
        for (int i = 1; i <= n; ++i) {
            fact[i] = fact[i - 1] * i % MOD;
            invFact[i] = modPow(fact[i], MOD - 2);
        }

        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            char c = s[i];
            for (int j = 0; j < (c - 'a'); ++j) {
                if (freq[j] == 0) continue;
                long long temp = fact[n - i - 1];
                for (int k = 0; k < 26; ++k) {
                    if (freq[k] == 0) continue;
                    temp = temp * invFact[freq[k] - (k == j)] % MOD;
                }
                res = (res + temp) % MOD;
            }
            freq[c - 'a']--;
        }
        return res;
    }
};