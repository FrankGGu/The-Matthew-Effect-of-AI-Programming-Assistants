int minimumDeletions(char *s, int k) {
    int freq[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }
    int unique = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) unique++;
    }
    if (unique <= k) return 0;

    int deletions = 0;
    int excess = unique - k;
    int freqArr[26];
    int index = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            freqArr[index++] = freq[i];
        }
    }
    qsort(freqArr, index, sizeof(int), cmp);
    for (int i = 0; i < excess; i++) {
        deletions += freqArr[i];
    }
    return deletions;
}

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}