#include <stdbool.h>

#define MAX_PRIME_LIMIT 32000000

bool is_prime[MAX_PRIME_LIMIT];
bool sieve_initialized = false;

void sieve() {
    if (sieve_initialized) {
        return;
    }

    for (int i = 0; i < MAX_PRIME_LIMIT; i++) {
        is_prime[i] = true;
    }
    is_prime[0] = false;
    is_prime[1] = false;

    for (long long p = 2; p * p < MAX_PRIME_LIMIT; p++) {
        if (is_prime[p]) {
            for (long long i = p * p; i < MAX_PRIME_LIMIT; i += p) {
                is_prime[i] = false;
            }
        }
    }
    sieve_initialized = true;
}

long long nonSpecialCount(long long l, long long r) {
    sieve();

    long long special_count = 0;

    for (int p = 2; p < MAX_PRIME_LIMIT; p++) {
        if (is_prime[p]) {
            long long special_num = (long long)p * p;

            if (special_num > r) {
                break;
            }

            if (special_num >= l) {
                special_count++;
            }
        }
    }

    return (r - l + 1) - special_count;
}