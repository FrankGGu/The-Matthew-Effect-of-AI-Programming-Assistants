int maxProduct(char **words, int wordsSize) {
    int maxProd = 0;
    int bitmask[wordsSize];

    for (int i = 0; i < wordsSize; i++) {
        bitmask[i] = 0;
        for (char *c = words[i]; *c; c++) {
            bitmask[i] |= 1 << (*c - 'a');
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((bitmask[i] & bitmask[j]) == 0) {
                int product = strlen(words[i]) * strlen(words[j]);
                if (product > maxProd) {
                    maxProd = product;
                }
            }
        }
    }

    return maxProd;
}