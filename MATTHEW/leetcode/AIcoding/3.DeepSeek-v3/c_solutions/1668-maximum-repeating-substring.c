int maxRepeating(char* sequence, char* word) {
    int max = 0;
    int wordLen = strlen(word);
    int seqLen = strlen(sequence);

    for (int i = 0; i < seqLen; i++) {
        int count = 0;
        int j = i;
        while (j + wordLen <= seqLen && strncmp(sequence + j, word, wordLen) == 0) {
            count++;
            j += wordLen;
        }
        if (count > max) {
            max = count;
        }
    }

    return max;
}