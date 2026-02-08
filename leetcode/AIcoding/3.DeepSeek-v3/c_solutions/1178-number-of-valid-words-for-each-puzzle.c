/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findNumOfValidWords(char** words, int wordsSize, char** puzzles, int puzzlesSize, int* returnSize) {
    *returnSize = puzzlesSize;
    int* res = (int*)calloc(puzzlesSize, sizeof(int));

    // Precompute word masks
    int* wordMasks = (int*)malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        int mask = 0;
        for (int j = 0; words[i][j] != '\0'; j++) {
            mask |= (1 << (words[i][j] - 'a'));
        }
        wordMasks[i] = mask;
    }

    // For each puzzle
    for (int i = 0; i < puzzlesSize; i++) {
        int puzzleMask = 0;
        for (int j = 0; puzzles[i][j] != '\0'; j++) {
            puzzleMask |= (1 << (puzzles[i][j] - 'a'));
        }

        int firstCharMask = (1 << (puzzles[i][0] - 'a'));
        int count = 0;

        // Check each word
        for (int j = 0; j < wordsSize; j++) {
            if ((wordMasks[j] & firstCharMask) == 0) continue;
            if ((wordMasks[j] | puzzleMask) == puzzleMask) {
                count++;
            }
        }

        res[i] = count;
    }

    free(wordMasks);
    return res;
}