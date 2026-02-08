int countPalindromicSubsequence(char* s) {
    int first[26], last[26];
    for (int i = 0; i < 26; i++) {
        first[i] = -1;
        last[i] = -1;
    }

    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        int idx = s[i] - 'a';
        if (first[idx] == -1) {
            first[idx] = i;
        }
        last[idx] = i;
    }

    int res = 0;
    for (int i = 0; i < 26; i++) {
        if (first[i] == -1 || first[i] == last[i]) {
            continue;
        }

        int seen[26] = {0};
        for (int j = first[i] + 1; j < last[i]; j++) {
            int mid = s[j] - 'a';
            if (!seen[mid]) {
                seen[mid] = 1;
                res++;
            }
        }
    }

    return res;
}