int nthSuperUglyNumber(int n, int* primes, int primesSize) {
    int* ugly = (int*)malloc(n * sizeof(int));
    ugly[0] = 1;

    int* indices = (int*)calloc(primesSize, sizeof(int));
    int* values = (int*)malloc(primesSize * sizeof(int));

    for (int i = 0; i < primesSize; i++) {
        values[i] = primes[i];
    }

    for (int i = 1; i < n; i++) {
        int min_val = values[0];
        for (int j = 1; j < primesSize; j++) {
            if (values[j] < min_val) {
                min_val = values[j];
            }
        }

        ugly[i] = min_val;

        for (int j = 0; j < primesSize; j++) {
            if (values[j] == min_val) {
                indices[j]++;
                values[j] = ugly[indices[j]] * primes[j];
            }
        }
    }

    int result = ugly[n - 1];
    free(ugly);
    free(indices);
    free(values);

    return result;
}