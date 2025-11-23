int largestInteger(int num) {
    char digits[11];
    sprintf(digits, "%d", num);
    int len = strlen(digits);

    for (int i = 0; i < len; i++) {
        for (int j = i + 1; j < len; j++) {
            int d1 = digits[i] - '0';
            int d2 = digits[j] - '0';
            if ((d1 % 2) == (d2 % 2) && d2 > d1) {
                char temp = digits[i];
                digits[i] = digits[j];
                digits[j] = temp;
            }
        }
    }

    return atoi(digits);
}