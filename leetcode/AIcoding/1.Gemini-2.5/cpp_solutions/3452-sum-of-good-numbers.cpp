#include <string>
#include <vector>
#include <algorithm> // For std::fill

const int MAX_DIGIT_SUM = 90; // Max sum of digits for 10 digits (e.g., 9*10=90)

std::vector<bool> is_prime_sieve(MAX_DIGIT_SUM + 1);
std::vector<long long> powers_of_10;

struct Result {
    long long count;
    long long sum;
};

std::vector<std::vector<std::vector<std::vector<Result>>>> memo;

void init_sieve_and_powers() {
    std::fill(is_prime_sieve.begin(), is_prime_sieve.end(), true);
    is_prime_sieve[0] = is_prime_sieve[1] = false;
    for (int p = 2; p * p <= MAX_DIGIT_SUM; ++p) {
        if (is_prime_sieve[p]) {
            for (int i = p * p; i <= MAX_DIGIT_SUM; i += p)
                is_prime_sieve[i] = false;
        }
    }

    // Numbers up to 2 * 10^9 have at most 10 digits.
    powers_of_10.resize(10);
    powers_of_10[0] = 1;
    for (int i = 1; i < 10; ++i) {
        powers_of_10[i] = powers_of_10[i - 1] * 10;
    }
}

Result dp(const std::string& s, int idx, int current_sum, bool tight, bool is_leading_zero) {
    if (idx == s.length()) {
        // If is_leading_zero is true, it means we formed an empty number or 0.
        // The number 0 has digit sum 0, which is not prime. So it's not a "good number".
        // Thus, if is_leading_zero is true, we return {0,0}.
        if (is_leading_zero) {
            return {0, 0};
        }
        // If it's a valid number (not leading zero)
        if (current_sum <= MAX_DIGIT_SUM && is_prime_sieve[current_sum]) {
            return {1, 0}; // Count 1, sum 0. The actual number sum is accumulated by digits.
        }
        return {0, 0};
    }

    if (memo[idx][current_sum][tight][is_leading_zero].count != -1) {
        return memo[idx][current_sum][tight][is_leading_zero];
    }

    Result total_res = {0, 0};
    int upper_bound = tight ? (s[idx] - '0') : 9;

    for (int digit = 0; digit <= upper_bound; ++digit) {
        if (is_leading_zero && digit == 0) {
            // Still placing leading zeros
            Result res = dp(s, idx + 1, 0, tight && (digit == upper_bound), true);
            total_res.count += res.count;
            total_res.sum += res.sum;
        } else {
            // Not leading zero anymore (or first non-zero digit)
            Result res = dp(s, idx + 1, current_sum + digit, tight && (digit == upper_bound), false);
            total_res.count += res.count;
            // The sum contribution of 'digit' at this position
            // is digit * 10^(s.length() - 1 - idx) for each number counted by res.count
            // plus the sum from lower positions (res.sum)
            long long current_pos_power = powers_of_10[s.length() - 1 - idx];
            total_res.sum += res.sum + res.count * digit * current_pos_power;
        }
    }

    return memo[idx][current_sum][tight][is_leading_zero] = total_res;
}

long long calculate_sum_up_to(int N) {
    if (N < 0) return 0;
    if (N == 0) { // The number 0 has digit sum 0, which is not prime. So 0 is not a good number.
        return 0;
    }

    std::string s = std::to_string(N);
    // Initialize memoization table for the current call
    memo.assign(s.length() + 1,
                std::vector<std::vector<std::vector<Result>>>(MAX_DIGIT_SUM + 1,
                                                               std::vector<std::vector<Result>>(2,
                                                                                                std::vector<Result>(2, {-1, -1}))));
    return dp(s, 0, 0, true, true).sum;
}

class Solution {
public:
    // Static flag to ensure sieve and powers_of_10 are initialized only once
    static bool initialized;

    long long sumOfGoodNumbers(int L, int R) {
        if (!initialized) {
            init_sieve_and_powers();
            initialized = true;
        }

        // The sum of good numbers in [L, R] is
        // (sum of good numbers up to R) - (sum of good numbers up to L-1).
        return calculate_sum_up_to(R) - calculate_sum_up_to(L - 1);
    }
};

bool Solution::initialized = false;