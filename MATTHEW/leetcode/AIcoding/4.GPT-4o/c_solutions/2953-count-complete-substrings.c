int countCompleteSubstrings(char * s) {
    int n = strlen(s), count = 0, uniqueCount = 0;
    int freq[256] = {0};

    for (int i = 0; i < n; i++) {
        if (freq[s[i]] == 0) uniqueCount++;
        freq[s[i]]++;
    }

    for (int len = 1; len <= n; len++) {
        memset(freq, 0, sizeof(freq));
        int currentUnique = 0;
        for (int i = 0; i < n; i++) {
            if (i >= len) {
                freq[s[i - len]]--;
                if (freq[s[i - len]] == 0) currentUnique--;
            }
            freq[s[i]]++;
            if (freq[s[i]] == 1) currentUnique++;
            if (i >= len - 1 && currentUnique == uniqueCount) count++;
        }
    }
    return count;
}