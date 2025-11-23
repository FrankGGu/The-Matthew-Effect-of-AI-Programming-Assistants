long long chalkReplacer(int* chalk, int chalkSize, long long k) {
    long long totalChalkSum = 0;
    for (int i = 0; i < chalkSize; i++) {
        totalChalkSum += chalk[i];
    }

    k %= totalChalkSum;

    for (int i = 0; i < chalkSize; i++) {
        if (k < chalk[i]) {
            return i;
        }
        k -= chalk[i];
    }
    return -1; // Should not reach here based on problem constraints
}