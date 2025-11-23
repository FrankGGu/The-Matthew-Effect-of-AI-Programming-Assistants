int minimumLength(char* s) {
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int result = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            if (freq[i] % 2 == 0) {
                result += 2;
            } else {
                result += 1;
            }
        }
    }

    return result;
}