#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long smallestGoodBase(long long n) {
    long long m = (long long)log2(n) + 1;
    for (long long len = m; len >= 2; len--) {
        long long k_low = 2;
        long long k_high = (long long)pow(n, 1.0 / (len - 1)) + 1;
        while (k_low <= k_high) {
            long long k = k_low + (k_high - k_low) / 2;
            long long sum = 1;
            long long term = 1;
            int overflow = 0;
            for (long long i = 1; i < len; i++) {
                if ((double)term > (double)n / k) {
                    overflow = 1;
                    break;
                }
                term *= k;
                if ((double)sum > (double)n - term) {
                    overflow = 1;
                    break;
                }
                sum += term;
            }

            if (overflow) {
                k_high = k - 1;
                continue;
            }

            if (sum == n) {
                return k;
            } else if (sum < n) {
                k_low = k + 1;
            } else {
                k_high = k - 1;
            }
        }
    }
    return n - 1;
}