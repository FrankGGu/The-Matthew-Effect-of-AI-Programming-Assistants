int maxRepeating(char *sequence, char *word) {
    int maxCount = 0, count = 0;
    int wordLen = strlen(word);
    int seqLen = strlen(sequence);

    while (count < seqLen) {
        if (strncmp(sequence + count, word, wordLen) == 0) {
            count += wordLen;
            maxCount++;
        } else {
            break;
        }
    }

    return maxCount;
}