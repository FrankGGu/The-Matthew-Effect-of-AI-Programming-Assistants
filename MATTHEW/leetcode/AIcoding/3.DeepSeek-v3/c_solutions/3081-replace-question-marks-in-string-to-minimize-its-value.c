char* minimizeStringValue(char* s) {
    int freq[26] = {0};
    int n = strlen(s);
    int q = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] != '?') {
            freq[s[i] - 'a']++;
        } else {
            q++;
        }
    }

    char* res = (char*)malloc((n + 1) * sizeof(char));
    strcpy(res, s);

    while (q > 0) {
        int minFreq = INT_MAX;
        for (int i = 0; i < 26; i++) {
            if (freq[i] < minFreq) {
                minFreq = freq[i];
            }
        }

        int count = 0;
        for (int i = 0; i < 26; i++) {
            if (freq[i] == minFreq) {
                count++;
            }
        }

        int fill = q < count ? q : count;
        for (int i = 0; i < 26 && fill > 0; i++) {
            if (freq[i] == minFreq) {
                for (int j = 0; j < n && fill > 0; j++) {
                    if (res[j] == '?') {
                        res[j] = 'a' + i;
                        freq[i]++;
                        q--;
                        fill--;
                        break;
                    }
                }
            }
        }
    }

    return res;
}