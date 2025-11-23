#define MOD 1000000007

int sumSubarrayMin(int* A, int ASize) {
    long long res = 0;
    int* left = (int*)malloc(ASize * sizeof(int));
    int* right = (int*)malloc(ASize * sizeof(int));

    for (int i = 0; i < ASize; i++) {
        left[i] = 1;
        right[i] = 1;
    }

    for (int i = 0; i < ASize; i++) {
        for (int j = i - 1; j >= 0 && A[j] > A[i]; j--) {
            left[i]++;
        }
        for (int j = i + 1; j < ASize && A[j] >= A[i]; j++) {
            right[i]++;
        }
    }

    for (int i = 0; i < ASize; i++) {
        res = (res + (long long)A[i] * left[i] * right[i]) % MOD;
    }

    free(left);
    free(right);

    return (int)res;
}