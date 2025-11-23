#define MOD 1000000007

int sumOfSubseqWidths(int* A, int ASize) {
    long long result = 0;
    long long pow2 = 1;
    qsort(A, ASize, sizeof(int), cmp);

    for (int i = 0; i < ASize; i++) {
        result = (result + (pow2 * (A[i] - A[ASize - 1 - i])) % MOD) % MOD;
        pow2 = (pow2 * 2) % MOD;
    }

    return (int)result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}