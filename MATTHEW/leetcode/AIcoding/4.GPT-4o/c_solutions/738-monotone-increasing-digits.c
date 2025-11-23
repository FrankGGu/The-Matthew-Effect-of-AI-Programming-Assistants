int monotoneIncreasingDigits(int N) {
    char num[11];
    sprintf(num, "%d", N);
    int len = strlen(num);
    int mark = len;

    for (int i = len - 1; i > 0; i--) {
        if (num[i] < num[i - 1]) {
            mark = i;
            num[i - 1]--;
        }
    }

    for (int i = mark; i < len; i++) {
        num[i] = '9';
    }

    return atoi(num);
}