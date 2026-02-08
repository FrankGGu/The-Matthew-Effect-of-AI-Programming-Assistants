int minimizedStringLength(char* s) {
    int freq[26] = {0};
    int count = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        freq[s[i] - 'a'] = 1;
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i]) {
            count++;
        }
    }

    return count;
}