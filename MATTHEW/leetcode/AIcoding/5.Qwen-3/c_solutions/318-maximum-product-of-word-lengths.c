#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProduct(char ** words, int wordsSize) {
    int n = wordsSize;
    int* masks = (int*)malloc(n * sizeof(int));
    int* lengths = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        masks[i] = 0;
        lengths[i] = strlen(words[i]);
        for (int j = 0; j < lengths[i]; j++) {
            masks[i] |= 1 << (words[i][j] - 'a');
        }
    }

    int maxProd = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if ((masks[i] & masks[j]) == 0) {
                int prod = lengths[i] * lengths[j];
                if (prod > maxProd) {
                    maxProd = prod;
                }
            }
        }
    }

    free(masks);
    free(lengths);
    return maxProd;
}