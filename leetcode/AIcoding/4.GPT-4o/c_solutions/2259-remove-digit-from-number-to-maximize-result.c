char *removeDigit(char *number, char digit, char *result) {
    int len = strlen(number);
    for (int i = 0; i < len; i++) {
        if (number[i] == digit) {
            if (i < len - 1 && number[i + 1] > digit) {
                strncpy(result, number, i);
                result[i] = '\0';
                strcat(result, number + i + 1);
                return result;
            }
        }
    }
    for (int i = len - 1; i >= 0; i--) {
        if (number[i] == digit) {
            strncpy(result, number, i);
            result[i] = '\0';
            strcat(result, number + i + 1);
            return result;
        }
    }
    return "";
}