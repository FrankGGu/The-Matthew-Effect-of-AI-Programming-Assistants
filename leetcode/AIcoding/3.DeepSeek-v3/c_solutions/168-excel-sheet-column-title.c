char* convertToTitle(int columnNumber) {
    int len = 0;
    long temp = columnNumber;
    while (temp > 0) {
        len++;
        temp = (temp - 1) / 26;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    result[len] = '\0';

    temp = columnNumber;
    for (int i = len - 1; i >= 0; i--) {
        result[i] = 'A' + (temp - 1) % 26;
        temp = (temp - 1) / 26;
    }

    return result;
}