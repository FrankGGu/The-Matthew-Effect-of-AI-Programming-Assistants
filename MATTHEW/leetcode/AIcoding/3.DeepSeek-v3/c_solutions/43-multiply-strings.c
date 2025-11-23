char* multiply(char* num1, char* num2) {
    if (num1[0] == '0' || num2[0] == '0') {
        char* result = malloc(2);
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int totalLen = len1 + len2;

    int* res = calloc(totalLen, sizeof(int));

    for (int i = len1 - 1; i >= 0; i--) {
        for (int j = len2 - 1; j >= 0; j--) {
            int mul = (num1[i] - '0') * (num2[j] - '0');
            int sum = mul + res[i + j + 1];
            res[i + j + 1] = sum % 10;
            res[i + j] += sum / 10;
        }
    }

    int start = 0;
    while (start < totalLen && res[start] == 0) {
        start++;
    }

    char* result = malloc(totalLen - start + 1);
    int idx = 0;
    for (int i = start; i < totalLen; i++) {
        result[idx++] = res[i] + '0';
    }
    result[idx] = '\0';

    free(res);
    return result;
}