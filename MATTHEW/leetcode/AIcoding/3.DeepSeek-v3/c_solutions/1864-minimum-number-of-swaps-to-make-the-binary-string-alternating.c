int minSwaps(char* s) {
    int n = strlen(s);
    int cnt1 = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') cnt1++;
    }
    int cnt0 = n - cnt1;

    if (abs(cnt1 - cnt0) > 1) return -1;

    int diff1 = 0, diff2 = 0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            if (s[i] != '1') diff1++;
            if (s[i] != '0') diff2++;
        } else {
            if (s[i] != '0') diff1++;
            if (s[i] != '1') diff2++;
        }
    }

    if (cnt1 > cnt0) return diff1 / 2;
    if (cnt0 > cnt1) return diff2 / 2;
    return (diff1 < diff2 ? diff1 : diff2) / 2;
}