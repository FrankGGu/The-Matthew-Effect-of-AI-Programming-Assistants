#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProduct(char** words, int wordsSize) {
    int masks[wordsSize];
    memset(masks, 0, sizeof(masks));

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; words[i][j] != '\0'; j++) {
            masks[i] |= (1 << (words[i][j] - 'a'));
        }
    }

    int maxProd = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((masks[i] & masks[j]) == 0) {
                int prod = strlen(words[i]) * strlen(words[j]);
                if (prod > maxProd) {
                    maxProd = prod;
                }
            }
        }
    }

    return maxProd;
}