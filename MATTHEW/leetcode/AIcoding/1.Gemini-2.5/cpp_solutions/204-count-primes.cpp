class Solution {
public:
    int countPrimes(int n) {
        if (n <= 2) {
            return 0;
        }

        std::vector<bool> is_prime(n, true);
        is_prime[0] = false;
        is_prime[1] = false;

        for (int p = 2; p * p < n; ++p) {
            if (is_prime[p]) {
                for (int multiple = p * p; multiple < n; multiple += p) {
                    is_prime[multiple] = false;
                }
            }
        }

        int count = 0;
        for (int i = 2; i < n; ++i) {
            if (is_prime[i]) {
                count++;
            }
        }

        return count;
    }
};