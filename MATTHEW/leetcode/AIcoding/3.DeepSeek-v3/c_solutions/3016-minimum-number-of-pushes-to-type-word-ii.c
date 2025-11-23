typedef struct {
    char letter;
    int freq;
} CharFreq;

int cmp(const void* a, const void* b) {
    return ((CharFreq*)b)->freq - ((CharFreq*)a)->freq;
}

int minimumPushes(char* word) {
    int freq[26] = {0};
    for (int i = 0; word[i]; i++) {
        freq[word[i] - 'a']++;
    }

    CharFreq cf[26];
    int count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            cf[count].letter = 'a' + i;
            cf[count].freq = freq[i];
            count++;
        }
    }

    qsort(cf, count, sizeof(CharFreq), cmp);

    int pushes = 0;
    for (int i = 0; i < count; i++) {
        pushes += cf[i].freq * (i / 8 + 1);
    }

    return pushes;
}