int shortestSubarray(int* A, int ASize, int K) {
    long long* prefix = (long long*)malloc((ASize + 1) * sizeof(long long));
    for (int i = 0; i < ASize; i++) {
        prefix[i + 1] = prefix[i] | A[i];
    }

    int result = ASize + 1;
    for (int i = 0; i < ASize; i++) {
        for (int j = i + 1; j <= ASize; j++) {
            if ((prefix[j] | prefix[i]) >= K) {
                result = result < (j - i) ? result : (j - i);
            }
        }
    }

    free(prefix);
    return result == ASize + 1 ? -1 : result;
}