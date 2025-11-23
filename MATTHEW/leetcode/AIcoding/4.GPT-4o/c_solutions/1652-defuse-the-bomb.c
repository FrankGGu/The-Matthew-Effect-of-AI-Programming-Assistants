int[] decrypt(int[] code, int k) {
    int n = sizeof(code) / sizeof(code[0]);
    int* result = (int*)malloc(n * sizeof(int));

    if (k == 0) {
        for (int i = 0; i < n; i++) {
            result[i] = 0;
        }
    } else {
        for (int i = 0; i < n; i++) {
            result[i] = 0;
            for (int j = 1; j <= abs(k); j++) {
                if (k > 0) {
                    result[i] += code[(i + j) % n];
                } else {
                    result[i] += code[(i - j + n) % n];
                }
            }
        }
    }

    return result;
}