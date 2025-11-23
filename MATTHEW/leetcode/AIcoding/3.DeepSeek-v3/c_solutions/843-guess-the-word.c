/**
 * *********************************************************************
 * // This is the Master's API interface.
 * // You should not implement it, or speculate about its implementation
 * *********************************************************************
 *
 * int guess(Master *, char *);
 */
typedef struct Master Master;

int diff(char* a, char* b) {
    int cnt = 0;
    for (int i = 0; i < 6; i++) {
        if (a[i] == b[i]) cnt++;
    }
    return cnt;
}

void findSecretWord(char** words, int wordsSize, Master* master) {
    for (int t = 0; t < 10; t++) {
        int idx = rand() % wordsSize;
        char* guessWord = words[idx];
        int matches = guess(master, guessWord);
        if (matches == 6) return;

        int newSize = 0;
        for (int i = 0; i < wordsSize; i++) {
            if (diff(guessWord, words[i]) == matches) {
                words[newSize++] = words[i];
            }
        }
        wordsSize = newSize;
    }
}