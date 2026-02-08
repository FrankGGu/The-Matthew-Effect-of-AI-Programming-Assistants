int maxProduct(char **words, int wordsSize) {
    int maxProd = 0;
    int masks[wordsSize];

    for (int i = 0; i < wordsSize; i++) {
        masks[i] = 0;
        for (char *c = words[i]; *c; c++) {
            masks[i] |= 1 << (*c - 'a');
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((masks[i] & masks[j]) == 0) {
                int product = strlen(words[i]) * strlen(words[j]);
                maxProd = maxProd > product ? maxProd : product;
            }
        }
    }

    return maxProd;
}