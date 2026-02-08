#include <vector>

using namespace std;

class Solution {
public:
    long long beautifulBouquet(vector<int>& flowers, int cnt) {
        int n = flowers.size();
        long long ans = 0;
        long long mod = 1e9 + 7;
        vector<int> freq(100001, 0);
        int left = 0;
        int distinct = 0;
        long long factorial[n + 1];
        factorial[0] = 1;
        for (int i = 1; i <= n; i++) {
            factorial[i] = (factorial[i - 1] * i) % mod;
        }

        auto power = [&](long long base, int exp) {
            long long res = 1;
            base %= mod;
            while (exp > 0) {
                if (exp % 2 == 1) res = (res * base) % mod;
                base = (base * base) % mod;
                exp /= 2;
            }
            return res;
        };

        auto inverse = [&](int a) {
            return power(a, mod - 2);
        };

        auto nCr = [&](int n, int r) {
            if (r < 0 || r > n) return 0LL;
            long long numerator = factorial[n];
            long long denominator = (factorial[r] * factorial[n - r]) % mod;
            return (numerator * inverse(denominator)) % mod;
        };

        for (int right = 0; right < n; right++) {
            if (freq[flowers[right]] == 0) {
                distinct++;
            }
            freq[flowers[right]]++;

            while (distinct > cnt) {
                freq[flowers[left]]--;
                if (freq[flowers[left]] == 0) {
                    distinct--;
                }
                left++;
            }

            ans = (ans + (right - left + 1)) % mod;
        }

        return ans;
    }
};