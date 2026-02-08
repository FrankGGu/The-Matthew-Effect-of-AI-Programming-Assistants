int nthSuperUglyNumber(int n, int* primes, int primesSize) {
    int* ugly = (int*)malloc(n * sizeof(int));
    int* indices = (int*)calloc(primesSize, sizeof(int));
    ugly[0] = 1;

    for (int i = 1; i < n; i++) {
        int next_ugly = INT_MAX;
        for (int j = 0; j < primesSize; j++) {
            next_ugly = fmin(next_ugly, primes[j] * ugly[indices[j]]);
        }
        ugly[i] = next_ugly;

        for (int j = 0; j < primesSize; j++) {
            if (next_ugly == primes[j] * ugly[indices[j]]) {
                indices[j]++;
            }
        }
    }

    int result = ugly[n - 1];
    free(ugly);
    free(indices);
    return result;
}