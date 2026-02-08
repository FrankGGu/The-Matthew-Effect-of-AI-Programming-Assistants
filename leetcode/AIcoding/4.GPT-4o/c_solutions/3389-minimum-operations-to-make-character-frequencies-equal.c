int minOperations(char *s) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
    }

    int maxFreq = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > maxFreq) {
            maxFreq = freq[i];
        }
    }

    int totalOperations = 0;
    for (int i = 0; i < 26; i++) {
        totalOperations += freq[i] > 0 ? freq[i] - maxFreq : 0;
    }

    return totalOperations;
}