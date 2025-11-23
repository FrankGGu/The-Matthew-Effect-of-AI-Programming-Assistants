class Solution {
public:
    int numPrimeArrangements(int n) {
        int primeCount = 0;
        vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int p = 2; p * p <= n; ++p) {
            if (isPrime[p]) {
                for (int i = p * p; i <= n; i += p) {
                    isPrime[i] = false;
                }
            }
        }
        for (int i = 2; i <= n; ++i) {
            if (isPrime[i]) {
                primeCount++;
            }
        }
        long long primeArrangements = 1;
        for (int i = 1; i <= primeCount; ++i) {
            primeArrangements = (primeArrangements * i) % 1000000007;
        }
        long long nonPrimeArrangements = 1;
        for (int i = 1; i <= n - primeCount; ++i) {
            nonPrimeArrangements = (nonPrimeArrangements * i) % 1000000007;
        }
        return (primeArrangements * nonPrimeArrangements) % 1000000007;
    }
};