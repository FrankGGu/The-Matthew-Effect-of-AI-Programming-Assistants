#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countAnagrams(string s) {
        const int MOD = 1e9 + 7;
        vector<long long> fact(s.size() + 1, 1);
        for (int i = 1; i <= s.size(); ++i) {
            fact[i] = fact[i - 1] * i % MOD;
        }

        long long res = 1;
        istringstream iss(s);
        string word;
        while (iss >> word) {
            unordered_map<char, int> freq;
            for (char c : word) {
                freq[c]++;
            }
            long long denominator = 1;
            for (auto& [ch, cnt] : freq) {
                denominator = denominator * fact[cnt] % MOD;
            }
            long long numerator = fact[word.size()];
            res = res * numerator % MOD;
            res = res * modInverse(denominator, MOD) % MOD;
        }
        return res;
    }

private:
    long long modInverse(long long a, int mod) {
        return power(a, mod - 2, mod);
    }

    long long power(long long x, int y, int mod) {
        long long res = 1;
        x = x % mod;
        while (y > 0) {
            if (y & 1) {
                res = (res * x) % mod;
            }
            y = y >> 1;
            x = (x * x) % mod;
        }
        return res;
    }
};