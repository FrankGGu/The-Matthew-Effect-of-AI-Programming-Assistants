int minimumDifference(int num) {
    char str[11];
    sprintf(str, "%d", num);
    int len = strlen(str);
    int minNum = 0, maxNum = 0;
    int minDigit[10] = {0}, maxDigit[10] = {0};

    for (int i = 0; i < len; i++) {
        int digit = str[i] - '0';
        if (minDigit[digit] == 0) {
            minDigit[digit] = digit + 1;
        }
        if (maxDigit[digit] == 0) {
            maxDigit[digit] = digit + 1;
        }
    }

    for (int i = 0; i < len; i++) {
        int digit = str[i] - '0';
        if (minDigit[digit] > 0) {
            minNum = minNum * 10 + minDigit[digit] - 1;
            minDigit[digit] = 0;
        } else {
            minNum = minNum * 10 + digit;
        }

        if (maxDigit[digit] > 0) {
            maxNum = maxNum * 10 + maxDigit[digit] - 1;
            maxDigit[digit] = 0;
        } else {
            maxNum = maxNum * 10 + digit;
        }
    }

    return maxNum - minNum;
}