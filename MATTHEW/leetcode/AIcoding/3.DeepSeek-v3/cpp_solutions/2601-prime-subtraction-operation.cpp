class Solution {
public:
    bool primeSubOperation(vector<int>& nums) {
        vector<int> primes = getPrimes(1000);
        int n = nums.size();
        int prev = 0;
        for (int i = 0; i < n; ++i) {
            int x = nums[i];
            int max_p = 0;
            for (int p : primes) {
                if (p >= x) break;
                if (x - p > prev) {
                    max_p = p;
                }
            }
            if (max_p == 0) {
                if (x <= prev) {
                    return false;
                }
                prev = x;
            } else {
                prev = x - max_p;
            }
        }
        return true;
    }

private:
    vector<int> getPrimes(int limit) {
        vector<bool> is_prime(limit + 1, true);
        is_prime[0] = is_prime[1] = false;
        for (int i = 2; i * i <= limit; ++i) {
            if (is_prime[i]) {
                for (int j = i * i; j <= limit; j += i) {
                    is_prime[j] = false;
                }
            }
        }
        vector<int> primes;
        for (int i = 2; i <= limit; ++i) {
            if (is_prime[i]) {
                primes.push_back(i);
            }
        }
        return primes;
    }
};