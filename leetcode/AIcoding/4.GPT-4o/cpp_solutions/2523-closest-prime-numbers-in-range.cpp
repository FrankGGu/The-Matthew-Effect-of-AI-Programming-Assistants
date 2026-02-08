class Solution {
public:
    vector<int> closestPrimes(int left, int right) {
        vector<int> primes;
        vector<bool> isPrime(right + 1, true);
        isPrime[0] = isPrime[1] = false;

        for (int i = 2; i * i <= right; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= right; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        for (int i = left; i <= right; ++i) {
            if (isPrime[i]) {
                primes.push_back(i);
            }
        }

        if (primes.size() < 2) {
            return {-1, -1};
        }

        int minDiff = INT_MAX;
        pair<int, int> closest = {-1, -1};

        for (size_t i = 1; i < primes.size(); ++i) {
            int diff = primes[i] - primes[i - 1];
            if (diff < minDiff) {
                minDiff = diff;
                closest = {primes[i - 1], primes[i]};
            }
        }

        return {closest.first, closest.second};
    }
};