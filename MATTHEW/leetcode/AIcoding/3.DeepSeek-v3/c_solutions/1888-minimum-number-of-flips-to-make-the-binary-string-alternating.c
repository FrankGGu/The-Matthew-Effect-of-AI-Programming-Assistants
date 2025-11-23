int minFlips(char* s) {
    int n = strlen(s);
    int diff1 = 0, diff2 = 0;
    int res = n;

    for (int i = 0; i < 2 * n; i++) {
        char c = s[i % n];

        if (i < n) {
            if (c != '0' + (i % 2)) diff1++;
            if (c != '0' + ((i + 1) % 2)) diff2++;
        } else {
            if (c != '0' + (i % 2)) diff1++;
            if (c != '0' + ((i + 1) % 2)) diff2++;

            int j = i - n;
            if (s[j] != '0' + (j % 2)) diff1--;
            if (s[j] != '0' + ((j + 1) % 2)) diff2--;
        }

        if (i >= n - 1) {
            res = fmin(res, fmin(diff1, diff2));
        }
    }

    return res;
}