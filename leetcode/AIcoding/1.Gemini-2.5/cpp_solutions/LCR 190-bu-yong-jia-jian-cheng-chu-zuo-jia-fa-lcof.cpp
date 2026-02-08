#include <vector>
#include <numeric>

class Solution {
private:
    const int MOD = 1337;

    // Helper function for modular exponentiation: (base^exp) % MOD
    int power(int base, int exp) {
        int res = 1;
        base %= MOD; // Ensure base is within modulo range
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (1LL * res * base) % MOD; // Use 1LL for intermediate product to prevent overflow
            }
            base = (1LL * base * base) % MOD; // Use 1LL for intermediate product
            exp /= 2;
        }
        return res;
    }

public:
    int superPow(int a, std::vector<int>& b) {
        if (b.empty()) {
            return 1;
        }

        a %= MOD; // Reduce 'a' initially to prevent large numbers in power calculations

        int result = 1;
        // Process digits of b from left to right
        // The formula for a^(b_1 b_2 ... b_k) is a^((b_1 b_2 ... b_{k-1}) * 10 + b_k)
        // which equals (a^(b_1 b_2 ... b_{k-1}))^10 * (a^b_k)
        for (int digit : b) {
            // current_result = (previous_result^10 * a^digit) % MOD
            // previous_result is essentially a^(b_1...b_{i-1})
            // a^digit is calculated using the power function
            int term1 = power(result, 10);
            int term2 = power(a, digit);
            result = (1LL * term1 * term2) % MOD; // Use 1LL for intermediate product
        }
        return result;
    }
};