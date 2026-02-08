#include <string>
#include <vector>

using namespace std;

const int MOD = 1e9 + 7;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

long long factorial(int n, vector<long long>& fact) {
    if (fact[n] != -1) return fact[n];
    if (n == 0) return fact[n] = 1;
    return fact[n] = (n * factorial(n - 1, fact)) % MOD;
}

int countSubstrings(string s, string t) {
    int n = s.length();
    int m = t.length();
    int ans = 0;

    for (int len = m; len <= n; ++len) {
        for (int i = 0; i <= n - len; ++i) {
            string sub = s.substr(i, len);
            vector<int> sub_freq(26, 0);
            vector<int> t_freq(26, 0);

            for (char c : sub) {
                sub_freq[c - 'a']++;
            }
            for (char c : t) {
                t_freq[c - 'a']++;
            }

            bool possible = true;
            for (int j = 0; j < 26; ++j) {
                if (t_freq[j] > sub_freq[j]) {
                    possible = false;
                    break;
                }
            }

            if (possible) {
                ans++;
            }
        }
    }

    return ans;
}