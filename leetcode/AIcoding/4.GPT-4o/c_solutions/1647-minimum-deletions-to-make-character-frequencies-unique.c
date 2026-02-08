int minDeletions(char * s) {
    int freq[26] = {0};
    int count = 0;
    int seen[100001] = {0};

    for (int i = 0; s[i] != '\0'; i++) {
        freq[s[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        while (freq[i] > 0 && seen[freq[i]]) {
            freq[i]--;
            count++;
        }
        seen[freq[i]]++;
    }

    return count;
}