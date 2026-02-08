#include <stdio.h>
#include <stdlib.h>

long long findKthNumber(long long n, long long k) {
    long long curr = 1;
    long long prev = 0;
    while (k > 0) {
        long long steps = 0;
        long long a = curr;
        long long b = curr + 1;
        while (a <= n) {
            steps += (n - a + 1);
            a *= 10;
            b *= 10;
        }
        if (k > steps) {
            k -= steps;
            curr++;
        } else {
            k--;
            curr *= 10;
        }
    }
    return curr;
}