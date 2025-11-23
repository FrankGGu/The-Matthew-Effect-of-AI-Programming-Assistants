#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int stringCount(string s) {
        int n = s.length();
        long long fact[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % 1000000007;
        }

        long long ans = 0;
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        for (int i = 0; i < n; i++) {
            long long denominator = 1;
            for (int j = 0; j < 26; j++) {
                denominator = (denominator * fact[freq[j]]) % 1000000007;
            }

            long long numerator = fact[n - i - 1];
            long long inv_denominator = power(denominator, 1000000007 - 2);

            for (int j = 0; j < s[i] - 'a'; j++) {
                if (freq[j] > 0) {
                    ans = (ans + (numerator * power((denominator * power(fact[freq[j]], 1000000007 - 2)) % 1000000007, 1000000007-2) % 1000000007) * freq[j]) % 1000000007;
                }
            }
            freq[s[i] - 'a']--;
        }

        return ans;
    }

    long long power(long long base, long long exp) {
        long long res = 1;
        base %= 1000000007;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % 1000000007;
            base = (base * base) % 1000000007;
            exp /= 2;
        }
        return res;
    }
};