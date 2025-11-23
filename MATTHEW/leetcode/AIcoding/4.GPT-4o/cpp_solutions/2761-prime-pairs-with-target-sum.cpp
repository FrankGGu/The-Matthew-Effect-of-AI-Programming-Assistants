class Solution {
public:
    int primePairs(int n) {
        vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        int count = 0;
        for (int i = 2; i <= n / 2; ++i) {
            if (isPrime[i] && isPrime[n - i]) {
                count++;
            }
        }

        return count;
    }
};