int maxProduct(char ** words, int wordsSize) {
    if (wordsSize < 2) {
        return 0;
    }

    int masks[wordsSize];
    int lengths[wordsSize];

    for (int i = 0; i < wordsSize; i++) {
        int current_mask = 0;
        int current_length = 0;
        char *word = words[i];

        for (int j = 0; word[j] != '\0'; j++) {
            current_mask |= (1 << (word[j] - 'a'));
            current_length++;
        }

        masks[i] = current_mask;
        lengths[i] = current_length;
    }

    int max_product = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((masks[i] & masks[j]) == 0) {
                int current_product = lengths[i] * lengths[j];
                if (current_product > max_product) {
                    max_product = current_product;
                }
            }
        }
    }

    return max_product;
}