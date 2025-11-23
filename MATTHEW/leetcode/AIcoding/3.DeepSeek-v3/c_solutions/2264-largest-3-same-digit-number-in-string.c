char* largestGoodInteger(char* num) {
    char* result = malloc(4 * sizeof(char));
    result[0] = '\0';
    char maxChar = '\0';

    for (int i = 0; i < strlen(num) - 2; i++) {
        if (num[i] == num[i+1] && num[i] == num[i+2]) {
            if (maxChar == '\0' || num[i] > maxChar) {
                maxChar = num[i];
            }
        }
    }

    if (maxChar != '\0') {
        result[0] = maxChar;
        result[1] = maxChar;
        result[2] = maxChar;
        result[3] = '\0';
    }

    return result;
}