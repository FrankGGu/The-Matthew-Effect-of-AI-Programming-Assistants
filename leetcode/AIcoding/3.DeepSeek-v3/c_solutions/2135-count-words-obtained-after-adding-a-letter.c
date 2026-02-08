int wordCount(char** startWords, int startWordsSize, char** targetWords, int targetWordsSize) {
    int* startMasks = (int*)malloc(startWordsSize * sizeof(int));
    for (int i = 0; i < startWordsSize; i++) {
        int mask = 0;
        for (int j = 0; startWords[i][j] != '\0'; j++) {
            mask |= (1 << (startWords[i][j] - 'a'));
        }
        startMasks[i] = mask;
    }

    int count = 0;
    for (int i = 0; i < targetWordsSize; i++) {
        int targetMask = 0;
        int len = strlen(targetWords[i]);
        for (int j = 0; j < len; j++) {
            targetMask |= (1 << (targetWords[i][j] - 'a'));
        }

        for (int j = 0; j < len; j++) {
            int charMask = 1 << (targetWords[i][j] - 'a');
            int startMask = targetMask ^ charMask;

            for (int k = 0; k < startWordsSize; k++) {
                if (startMasks[k] == startMask) {
                    count++;
                    j = len;
                    break;
                }
            }
        }
    }

    free(startMasks);
    return count;
}