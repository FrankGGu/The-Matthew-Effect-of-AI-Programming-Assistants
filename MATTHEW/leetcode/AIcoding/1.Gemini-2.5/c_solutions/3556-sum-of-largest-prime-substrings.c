#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool isPrime(long long n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    for (long long i = 5; i * i <= n; i = i + 6) {
        if (n % i == 0 || n % (i + 2) == 0)
            return false;
    }
    return true;
}

#define MAX_SUBSTRING_LEN_FOR_PRIME_CHECK 10

long long sumOfLargestPrimeSubstrings(char* s) {
    int n = strlen(s);
    long long totalSum = 0;

    for (int i = 0; i < n; ++i) {
        long long maxPrimeFor_i = 0;
        long long currentNum = 0;

        // If a substring starts with '0', it's generally not considered a valid number
        // for primality testing, unless it's the single digit '0'.
        // The number '0' is not prime. Thus, if s[i] is '0', no prime can be formed
        // starting from this position (as multi-digit numbers like "01" are invalid).
        if (s[i] == '0') {
            continue;
        }

        for (int j = i; j < n; ++j) {
            // Limit substring length to avoid extremely large numbers and potential TLE
            // on primality tests, and also to prevent long long overflow if the string is very long.
            if (j - i + 1 > MAX_SUBSTRING_LEN_FOR_PRIME_CHECK) {
                break;
            }

            currentNum = currentNum * 10 + (s[j] - '0');

            // Check if the current number is prime and larger than maxPrimeFor_i
            if (isPrime(currentNum)) {
                if (currentNum > maxPrimeFor_i) {
                    maxPrimeFor_i = currentNum;
                }
            }
        }
        totalSum += maxPrimeFor_i;
    }

    return totalSum;
}