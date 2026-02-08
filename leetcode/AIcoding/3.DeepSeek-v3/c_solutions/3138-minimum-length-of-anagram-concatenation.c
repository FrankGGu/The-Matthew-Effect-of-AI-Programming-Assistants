int minAnagramLength(char* s) {
    int n = strlen(s);
    for (int len = 1; len <= n / 2; len++) {
        if (n % len != 0) continue;

        int count[26] = {0};
        for (int i = 0; i < len; i++) {
            count[s[i] - 'a']++;
        }

        int valid = 1;
        for (int i = len; i < n; i += len) {
            int temp[26] = {0};
            for (int j = i; j < i + len; j++) {
                temp[s[j] - 'a']++;
            }

            for (int k = 0; k < 26; k++) {
                if (count[k] != temp[k]) {
                    valid = 0;
                    break;
                }
            }
            if (!valid) break;
        }

        if (valid) return len;
    }
    return n;
}