char* lastNonEmptyString(char* s) {
    int freq[26] = {0};
    int maxFreq = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
        if (freq[s[i] - 'a'] > maxFreq) {
            maxFreq = freq[s[i] - 'a'];
        }
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int idx = 0;

    for (int i = len - 1; i >= 0; i--) {
        if (freq[s[i] - 'a'] == maxFreq) {
            result[idx++] = s[i];
            freq[s[i] - 'a'] = -1;
        }
    }

    result[idx] = '\0';

    for (int i = 0, j = idx - 1; i < j; i++, j--) {
        char temp = result[i];
        result[i] = result[j];
        result[j] = temp;
    }

    return result;
}