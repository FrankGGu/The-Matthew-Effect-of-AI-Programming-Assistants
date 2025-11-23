int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int minDeletions(char* s) {
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    qsort(freq, 26, sizeof(int), cmp);

    int deletions = 0;
    int maxFreq = len;

    for (int i = 0; i < 26 && freq[i] > 0; i++) {
        if (freq[i] > maxFreq) {
            deletions += freq[i] - maxFreq;
            freq[i] = maxFreq;
        }
        maxFreq = freq[i] - 1;
        if (maxFreq < 0) maxFreq = 0;
    }

    return deletions;
}