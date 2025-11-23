char* getPermutation(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int factorial[10] = {1};
    for (int i = 1; i <= n; i++) {
        factorial[i] = factorial[i - 1] * i;
    }

    int numbers[9];
    for (int i = 0; i < n; i++) {
        numbers[i] = i + 1;
    }

    k--;
    for (int i = 0; i < n; i++) {
        int index = k / factorial[n - 1 - i];
        result[i] = numbers[index] + '0';
        for (int j = index; j < n - 1 - i; j++) {
            numbers[j] = numbers[j + 1];
        }
        k %= factorial[n - 1 - i];
    }
    result[n] = '\0';
    return result;
}