char* maximumBinaryString(char* binary) {
    int n = strlen(binary);
    int countZero = 0, countOne = 0;

    for (int i = 0; i < n; i++) {
        if (binary[i] == '0') {
            countZero++;
        } else {
            countOne++;
        }
    }

    if (countZero == 0) {
        return strdup(binary);
    }

    char* result = (char*)malloc(n + 1);
    for (int i = 0; i < countOne; i++) {
        result[i] = '1';
    }
    result[countOne] = '0';
    for (int i = countOne + 1; i < n; i++) {
        result[i] = '1';
    }
    result[n] = '\0';

    return result;
}