int minDeletions(char* s, int k) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
    }

    int count[100001] = {0};
    int maxFreq = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            count[freq[i]]++;
            if (freq[i] > maxFreq) {
                maxFreq = freq[i];
            }
        }
    }

    int deletions = 0;
    for (int i = maxFreq; i > 0; i--) {
        if (count[i] > k) {
            int extra = count[i] - k;
            deletions += extra * i;
            count[i-1] += extra;
        }
    }

    return deletions;
}