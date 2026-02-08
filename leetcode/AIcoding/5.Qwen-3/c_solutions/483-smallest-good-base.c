#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long int pow_int(long long int base, long long int exp) {
    long long int result = 1;
    for (long long int i = 0; i < exp; i++) {
        result *= base;
        if (result < 0) return -1; // overflow
    }
    return result;
}

char* smallestGoodBase(char* n) {
    long long int N = atoll(n);
    long long int max_k = (long long int)(log(N) / log(2)) + 1;

    for (long long int k = max_k; k >= 2; k--) {
        long long int low = 2;
        long long int high = (long long int)(pow(N, 1.0 / k)) + 1;
        while (low <= high) {
            long long int mid = (low + high) / 2;
            long long int sum = 0;
            long long int current = 1;
            for (long long int i = 0; i < k; i++) {
                sum += current;
                current *= mid;
                if (sum > N || current > N) break;
            }
            if (sum == N) {
                char* res = (char*)malloc(20 * sizeof(char));
                sprintf(res, "%lld", mid);
                return res;
            } else if (sum < N) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
    }

    char* res = (char*)malloc(20 * sizeof(char));
    sprintf(res, "%lld", N);
    return res;
}