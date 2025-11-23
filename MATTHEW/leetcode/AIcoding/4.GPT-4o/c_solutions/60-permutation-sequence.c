char * getPermutation(int n, int k) {
    int factorial[10] = {1};
    char *result = (char *)malloc((n + 1) * sizeof(char));
    int nums[10];
    for (int i = 1; i < n; i++) {
        factorial[i] = factorial[i - 1] * i;
    }
    for (int i = 0; i < n; i++) {
        nums[i] = i + 1;
    }
    k--; 
    for (int i = 0; i < n; i++) {
        int index = k / factorial[n - 1 - i];
        result[i] = nums[index] + '0';
        for (int j = index; j < n - 1 - i; j++) {
            nums[j] = nums[j + 1];
        }
        k %= factorial[n - 1 - i];
    }
    result[n] = '\0';
    return result;
}