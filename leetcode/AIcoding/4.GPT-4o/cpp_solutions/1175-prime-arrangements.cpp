class Solution {
public:
    int numPrimeArrangements(int n) {
        int mod = 1e9 + 7;
        int primeCount = 0;
        vector<bool> isPrime(n + 1, true);

        for (int i = 2; i <= n; ++i) {
            if (isPrime[i]) {
                primeCount++;
                for (int j = 2 * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        long long res = 1;
        for (int i = 1; i <= primeCount; ++i) {
            res = (res * i) % mod;
        }

        for (int i = 1; i <= n - primeCount; ++i) {
            res = (res * i) % mod;
        }

        return res;
    }
};