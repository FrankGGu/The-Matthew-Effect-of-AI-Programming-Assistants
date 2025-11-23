class Solution {
public:
    int maxPrimeDifference(int n) {
        vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;

        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        int lastPrime = -1;
        int maxDiff = -1;

        for (int i = 2; i <= n; ++i) {
            if (isPrime[i]) {
                if (lastPrime != -1) {
                    maxDiff = max(maxDiff, i - lastPrime);
                }
                lastPrime = i;
            }
        }

        return maxDiff;
    }
};