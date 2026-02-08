int checkRecord(int n) {
    if (n == 1) return 3;

    long MOD = 1000000007;
    long* P = (long*)malloc((n + 1) * sizeof(long));
    long* L = (long*)malloc((n + 1) * sizeof(long));
    long* A = (long*)malloc((n + 1) * sizeof(long));

    P[0] = 1; P[1] = 1; P[2] = 3;
    L[0] = 1; L[1] = 1; L[2] = 3;
    A[0] = 1; A[1] = 1; A[2] = 2;

    for (int i = 1; i <= n; i++) {
        if (i == 1 || i == 2) continue;

        P[i] = (P[i-1] + L[i-1] + A[i-1]) % MOD;

        L[i] = (P[i-1] + A[i-1] + P[i-2] + A[i-2]) % MOD;

        if (i >= 4) {
            A[i] = (A[i-1] + A[i-2] + A[i-3]) % MOD;
        } else {
            if (i == 3) A[i] = 4;
        }
    }

    long result = (P[n] + L[n] + A[n]) % MOD;

    free(P);
    free(L);
    free(A);

    return (int)result;
}