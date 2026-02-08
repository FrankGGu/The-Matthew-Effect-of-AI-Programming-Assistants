int numberOfSubstrings(char* s, int k) {
    int n = strlen(s);
    int res = 0;

    for (int i = 0; i < n; i++) {
        int freq[26] = {0};
        for (int j = i; j < n; j++) {
            freq[s[j] - 'a']++;
            for (int c = 0; c < 26; c++) {
                if (freq[c] >= k) {
                    res++;
                    break;
                }
            }
        }
    }

    return res;
}