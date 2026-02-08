int maxProduct(char** words, int wordsSize) {
    int* masks = (int*)malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        masks[i] = 0;
        char* word = words[i];
        while (*word) {
            masks[i] |= 1 << (*word - 'a');
            word++;
        }
    }

    int max = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((masks[i] & masks[j]) == 0) {
                int product = strlen(words[i]) * strlen(words[j]);
                if (product > max) {
                    max = product;
                }
            }
        }
    }

    free(masks);
    return max;
}