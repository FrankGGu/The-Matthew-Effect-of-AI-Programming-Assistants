#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int maxProduct(char** words, int wordsSize) {
    int* masks = (int*)malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        masks[i] = 0;
        for (int j = 0; words[i][j]; j++) {
            masks[i] |= 1 << (words[i][j] - 'a');
        }
    }

    int maxProd = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((masks[i] & masks[j]) == 0) {
                int len = strlen(words[i]) * strlen(words[j]);
                if (len > maxProd) {
                    maxProd = len;
                }
            }
        }
    }

    free(masks);
    return maxProd;
}