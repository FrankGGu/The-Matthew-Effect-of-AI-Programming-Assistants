bool areOccurrencesEqual(char* s) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
    }

    int expected = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] != 0) {
            if (expected == 0) {
                expected = freq[i];
            } else if (freq[i] != expected) {
                return false;
            }
        }
    }
    return true;
}