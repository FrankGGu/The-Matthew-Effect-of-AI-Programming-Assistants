char * decrypt(const char * code, int k) {
    int n = strlen(code);
    char *result = (char *)malloc(n + 1);
    result[n] = '\0';

    if (k == 0) {
        for (int i = 0; i < n; i++) {
            result[i] = 'a' + (code[i] - '0');
        }
        return result;
    }

    int *nums = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        nums[i] = code[i] - '0';
    }

    for (int i = 0; i < n; i++) {
        int sum = 0;
        for (int j = 1; j <= abs(k); j++) {
            int idx = (i + (k > 0 ? j : -j) + n) % n;
            sum += nums[idx];
        }
        result[i] = 'a' + (sum % 26);
    }

    free(nums);
    return result;
}