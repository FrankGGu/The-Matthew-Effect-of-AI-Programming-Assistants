char* rearrangeString(char* s, int k) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
    }

    int n = strlen(s);
    char* result = (char*)malloc(n + 1);
    int idx = 0;

    while (idx < n) {
        int maxFreq = 0, maxChar = -1;
        for (int i = 0; i < 26; i++) {
            if (freq[i] > maxFreq) {
                maxFreq = freq[i];
                maxChar = i;
            }
        }

        if (maxChar == -1) break;

        result[idx++] = maxChar + 'a';
        freq[maxChar]--;

        if (idx >= k) {
            freq[result[idx - k] - 'a']++;
        }
    }

    result[idx] = '\0';
    return idx == n ? result : "";
}