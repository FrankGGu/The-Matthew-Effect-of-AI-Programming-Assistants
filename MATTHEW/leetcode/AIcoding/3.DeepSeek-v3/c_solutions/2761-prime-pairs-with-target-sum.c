/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findPrimePairs(int n, int* returnSize) {
    // Sieve of Eratosthenes to find primes up to n
    int* isPrime = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        isPrime[i] = 1;
    }
    isPrime[0] = isPrime[1] = 0;

    for (int i = 2; i * i <= n; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j <= n; j += i) {
                isPrime[j] = 0;
            }
        }
    }

    // Count the number of valid pairs
    int count = 0;
    for (int x = 2; x <= n / 2; x++) {
        int y = n - x;
        if (x <= y && isPrime[x] && isPrime[y]) {
            count++;
        }
    }

    // Allocate memory for result
    int* result = (int*)malloc(count * 2 * sizeof(int));
    *returnSize = count;

    // Fill the result array
    int idx = 0;
    for (int x = 2; x <= n / 2; x++) {
        int y = n - x;
        if (x <= y && isPrime[x] && isPrime[y]) {
            result[idx++] = x;
            result[idx++] = y;
        }
    }

    free(isPrime);
    return result;
}