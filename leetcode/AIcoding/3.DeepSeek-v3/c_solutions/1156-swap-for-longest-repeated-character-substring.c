int maxRepOpt1(char* text) {
    int count[26] = {0};
    int n = strlen(text);
    for (int i = 0; i < n; i++) {
        count[text[i] - 'a']++;
    }

    int res = 0;
    for (int i = 0; i < n; ) {
        int j = i;
        while (j < n && text[j] == text[i]) {
            j++;
        }
        int cur_cnt = j - i;

        if (cur_cnt < count[text[i] - 'a'] && (j < n || i > 0)) {
            res = fmax(res, cur_cnt + 1);
        }

        int k = j + 1;
        while (k < n && text[k] == text[i]) {
            k++;
        }
        int total = k - i - (j - i + 1) + 1;

        if (total > count[text[i] - 'a']) {
            total = count[text[i] - 'a'];
        }
        res = fmax(res, total);

        i = j;
    }
    return res;
}