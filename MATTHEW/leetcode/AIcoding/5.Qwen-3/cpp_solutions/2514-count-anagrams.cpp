#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countAnagrams(string s) {
        const int MOD = 1e9 + 7;
        vector<long long> fact(s.size() + 1, 1);
        for (int i = 2; i <= s.size(); ++i) {
            fact[i] = fact[i - 1] * i % MOD;
        }

        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        long long result = 1;
        for (auto& [c, count] : freq) {
            result = result * fact[s.size()] % MOD;
            result = result * pow(fact[count], MOD - 2, MOD) % MOD;
        }

        return result;
    }

    long long pow(long long a, long long b, long long mod) {
        long long res = 1;
        while (b > 0) {
            if (b % 2 == 1) {
                res = res * a % mod;
            }
            a = a * a % mod;
            b /= 2;
        }
        return res;
    }
};