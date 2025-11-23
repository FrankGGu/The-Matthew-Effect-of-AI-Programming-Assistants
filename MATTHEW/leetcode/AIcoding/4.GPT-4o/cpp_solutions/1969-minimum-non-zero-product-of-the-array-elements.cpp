class Solution {
public:
    int mod = 1e9 + 7;

    int minNonZeroProduct(int p) {
        long long maxNum = (1LL << p) - 1;
        long long half = maxNum / 2;
        long long result = modPow(maxNum, (1LL << (p - 1)) - 1);
        result = (result * (maxNum % mod)) % mod;
        return result;
    }

    long long modPow(long long base, long long exp) {
        long long res = 1;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
};