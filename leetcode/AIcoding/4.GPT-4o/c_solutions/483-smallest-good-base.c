char* smallestGoodBase(char* n) {
    long num = atol(n);
    for (long k = 60; k > 1; k--) {
        long base = pow(num, 1.0 / k);
        long sum = 1, cur = 1;
        for (int i = 0; i < k; i++) {
            cur *= base;
            sum += cur;
            if (sum > num) break;
        }
        if (sum == num) {
            char* result = (char*)malloc(20);
            sprintf(result, "%ld", base);
            return result;
        }
    }
    char* result = (char*)malloc(20);
    sprintf(result, "%ld", num - 1);
    return result;
}