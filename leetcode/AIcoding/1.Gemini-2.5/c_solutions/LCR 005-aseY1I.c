#include <string.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxProduct(char **words, int wordsSize) {
    if (wordsSize == 0) {
        return 0;
    }

    int *masks = (int *)malloc(wordsSize * sizeof(int));
    int *lengths = (int *)malloc(wordsSize * sizeof(int));

    for (int i = 0; i < wordsSize; i++) {
        int mask = 0;
        int len = 0;
        for (int j = 0; words[i][j] != '\0'; j++) {
            mask |= (1 << (words[i][j] - 'a'));
            len++;
        }
        masks[i] = mask;
        lengths[i] = len;
    }

    int max_product = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((masks[i] & masks[j]) == 0) {
                max_product = max(max_product, lengths[i] * lengths[j]);
            }
        }
    }

    free(masks);
    free(lengths);

    return max_product;
}