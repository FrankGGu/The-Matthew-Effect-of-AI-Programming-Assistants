int minSwaps(char *s) {
    int count0 = 0, count1 = 0, n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '0') count0++;
        else count1++;
    }

    if (abs(count0 - count1) > 1) return -1;

    int swaps0 = 0, swaps1 = 0;
    for (int i = 0; i < n; i++) {
        if ((i % 2 == 0 && s[i] == '1') || (i % 2 == 1 && s[i] == '0')) swaps0++;
        if ((i % 2 == 0 && s[i] == '0') || (i % 2 == 1 && s[i] == '1')) swaps1++;
    }

    if (count0 > count1) return swaps1 / 2;
    if (count1 > count0) return swaps0 / 2;

    return fmin(swaps0, swaps1) / 2;
}