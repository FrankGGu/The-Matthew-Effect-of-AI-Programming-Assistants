#define MAX_GUESSES 10

int findSecretWord(char **wordlist, int wordlistSize, int (*guess)(char*), int maxGuesses) {
    int count[WORD_SIZE][26] = {0};
    int i, j, k;

    for (i = 0; i < wordlistSize; ++i) {
        for (j = 0; j < WORD_SIZE; ++j) {
            count[j][wordlist[i][j] - 'a']++;
        }
    }

    for (i = 0; i < maxGuesses; ++i) {
        char *guessWord = NULL;
        int maxCount = -1;

        for (j = 0; j < wordlistSize; ++j) {
            int currentCount = 0;
            for (k = 0; k < WORD_SIZE; ++k) {
                currentCount += count[k][wordlist[j][k] - 'a'];
            }
            if (currentCount > maxCount) {
                maxCount = currentCount;
                guessWord = wordlist[j];
            }
        }

        int result = guess(guessWord);
        if (result == WORD_SIZE) {
            return;
        }

        for (j = 0; j < wordlistSize; ) {
            int matches = 0;
            for (k = 0; k < WORD_SIZE; ++k) {
                if (guessWord[k] == wordlist[j][k]) {
                    matches++;
                }
            }
            if (matches != result) {
                wordlist[j] = wordlist[--wordlistSize];
            } else {
                j++;
            }
        }
    }
}