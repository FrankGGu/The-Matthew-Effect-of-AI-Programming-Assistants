int atMostNGivenDigitSet(char **digits, int digitsSize, int n) {
    char numStr[12];
    sprintf(numStr, "%d", n);
    int len = strlen(numStr);
    int res = 0;

    for (int i = 1; i < len; i++) {
        res += pow(digitsSize, i);
    }

    for (int i = 0; i < len; i++) {
        int prefix = 0;
        for (int j = 0; j < digitsSize; j++) {
            if (digits[j][0] < numStr[i]) {
                prefix++;
            }
        }
        res += prefix * pow(digitsSize, len - i - 1);

        int match = 0;
        for (int j = 0; j < digitsSize; j++) {
            if (digits[j][0] == numStr[i]) {
                match = 1;
                break;
            }
        }
        if (!match) break;

        if (i == len - 1) res++;
    }

    return res;
}