int atMostNGivenDigitSet(char **digits, int digitsSize, int n) {
    char str[12];
    sprintf(str, "%d", n);
    int len = strlen(str);
    int count = 0;

    for (int i = 1; i < len; i++) {
        count += pow(digitsSize, i);
    }

    for (int i = 0; i < len; i++) {
        int isSmaller = 0;
        for (int j = 0; j < digitsSize; j++) {
            if (digits[j][0] < str[i]) {
                count += pow(digitsSize, len - i - 1);
            } else if (digits[j][0] == str[i]) {
                isSmaller = 1;
                break;
            }
        }
        if (!isSmaller) {
            break;
        }
    }

    return count + 1;
}