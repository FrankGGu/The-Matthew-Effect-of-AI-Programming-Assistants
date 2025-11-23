char *maximumBinaryString(char *binary) {
    int n = strlen(binary);
    int countZeroes = 0;
    for (int i = 0; i < n; i++) {
        if (binary[i] == '0') {
            countZeroes++;
        }
    }
    if (countZeroes == 0) {
        return binary;
    }
    char *result = (char *)malloc(n + 1);
    for (int i = 0; i < countZeroes; i++) {
        result[i] = '1';
    }
    result[countZeroes] = '0';
    for (int i = countZeroes + 1; i < n; i++) {
        result[i] = '1';
    }
    result[n] = '\0';
    return result;
}