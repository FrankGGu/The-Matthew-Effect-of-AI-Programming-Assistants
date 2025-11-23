#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int stringToInteger(string s) {
        long long res = 0;
        for (char c : s) {
            res = (res * 10 + (c - '0')) % 1000000007;
        }
        return (int)res;
    }

    int makeStringSorted(string s) {
        int n = s.length();
        vector<long long> fact(n + 1);
        fact[0] = 1;
        for (int i = 1; i <= n; ++i) {
            fact[i] = (fact[i - 1] * i) % 1000000007;
        }

        auto power = [&](long long base, long long exp) {
            long long res = 1;
            base %= 1000000007;
            while (exp > 0) {
                if (exp % 2 == 1) res = (res * base) % 1000000007;
                base = (base * base) % 1000000007;
                exp /= 2;
            }
            return res;
        };

        auto modInverse = [&](long long n) {
            return power(n, 1000000007 - 2);
        };

        int ans = 0;
        vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        for (int i = 0; i < n; ++i) {
            int smaller = 0;
            for (int j = 0; j < s[i] - 'a'; ++j) {
                smaller += counts[j];
            }

            long long denominator = 1;
            for (int j = 0; j < 26; ++j) {
                denominator = (denominator * fact[counts[j]]) % 1000000007;
            }

            long long numerator = (fact[n - i - 1] * smaller) % 1000000007;
            long long temp = (numerator * modInverse(denominator)) % 1000000007;
            ans = (ans + (int)temp) % 1000000007;
            counts[s[i] - 'a']--;
        }

        return ans;
    }
};