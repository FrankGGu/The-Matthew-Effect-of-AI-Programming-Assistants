#include <stdbool.h>

bool is_prime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int count_set_bits(int n) {
    int count = 0;
    while (n) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

int countPrimeSetBits(int L, int R) {
    int prime_count = 0;
    for (int i = L; i <= R; i++) {
        int set_bits = count_set_bits(i);
        if (is_prime(set_bits)) {
            prime_count++;
        }
    }
    return prime_count;
}