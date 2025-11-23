using namespace std;

class Solution {
public:
    int countGoodNumbers(long long n) {
        long long odd = n / 2;
        long long even = n - odd;
        long long mod = 1e9 + 7;

        long long ans = (power(5, even, mod) * power(4, odd, mod)) % mod;
        return ans;
    }

private:
    long long power(long long base, long long exp, long long mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
};