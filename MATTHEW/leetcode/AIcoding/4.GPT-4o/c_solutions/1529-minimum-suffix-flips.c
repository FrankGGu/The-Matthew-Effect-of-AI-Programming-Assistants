int minFlips(char *s) {
    int n = strlen(s);
    char *double_s = (char *)malloc(2 * n + 1);
    strcat(double_s, s);
    strcat(double_s, s);

    int count1 = 0, count2 = 0, result = n;

    for (int i = 0; i < 2 * n; i++) {
        if (i % 2 == 0) {
            count1 += (double_s[i] == '0');
            count2 += (double_s[i] == '1');
        } else {
            count1 += (double_s[i] == '1');
            count2 += (double_s[i] == '0');
        }
        if (i >= n) {
            if (i >= n + 1) {
                if ((i - n) % 2 == 0) {
                    count1 -= (double_s[i - n] == '0');
                    count2 -= (double_s[i - n] == '1');
                } else {
                    count1 -= (double_s[i - n] == '1');
                    count2 -= (double_s[i - n] == '0');
                }
            }
            result = fmin(result, fmin(count1, count2));
        }
    }

    free(double_s);
    return result;
}