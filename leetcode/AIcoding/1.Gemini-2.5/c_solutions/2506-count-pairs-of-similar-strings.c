#include <stdlib.h>
#include <string.h>

int similarPairs(char*** words, int wordsSize, int* wordsColSize) {
    int* masks = (int*)malloc(wordsSize * sizeof(int));

    for (int i = 0; i < wordsSize; i++) {
        int currentMask = 0;
        char* word = words[i];
        for (int j = 0; word[j] != '\0'; j++) {
            currentMask |= (1 << (word[j] - 'a'));
        }
        masks[i] = currentMask;
    }

    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if (masks[i] == masks[j]) {
                count++;
            }
        }
    }

    free(masks);
    return count;
}