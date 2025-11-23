#include <string>
#include <vector>
#include <climits>

class Solution {
private:
    long long power(long long base, long long exp, long long mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (__int128)res * base % mod;
            base = (__int128)base * base % mod;
            exp /= 2;
        }
        return res;
    }

    bool check_composite(long long n, long long a, long long d, int s) {
        long long x = power(a, d, n);
        if (x == 1 || x == n - 1)
            return false;
        for (int r = 1; r < s; r++) {
            x = (__int128)x * x % n;
            if (x == n - 1)
                return false;
        }
        return true;
    }

    bool isPrime(long long n) {
        if (n < 2)
            return false;
        int s = 0;
        long long d = n - 1;
        while ((d & 1) == 0) {
            d >>= 1;
            s++;
        }
        for (long long a : {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37}) {
            if (n == a)
                return true;
            if (check_composite(n, a, d, s))
                return false;
        }
        return true;
    }

public:
    long long sumOfLargestPrimeSubstrings(std::string s) {
        long long total_sum = 0;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            long long largest_prime_for_i = 0;
            long long current_num = 0;
            for (int j = i; j < n; ++j) {
                int digit = s[j] - '0';
                if (current_num > (LLONG_MAX - digit) / 10) {
                    break;
                }
                current_num = current_num * 10 + digit;

                if (isPrime(current_num)) {
                    largest_prime_for_i = current_num;
                }
            }
            total_sum += largest_prime_for_i;
        }
        return total_sum;
    }
};