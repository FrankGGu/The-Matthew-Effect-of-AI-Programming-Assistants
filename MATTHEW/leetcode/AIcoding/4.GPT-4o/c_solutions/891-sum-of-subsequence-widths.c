int sumSubseqWidths(int* A, int ASize) {
    long long mod = 1e9 + 7;
    long long result = 0;
    long long powerOfTwo = 1;

    qsort(A, ASize, sizeof(int), cmp);

    for (int i = 0; i < ASize; i++) {
        result = (result + (powerOfTwo * A[i]) % mod) % mod;
        result = (result - (powerOfTwo * A[ASize - 1 - i]) % mod + mod) % mod;
        powerOfTwo = (powerOfTwo * 2) % mod;
    }

    return (int)result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}