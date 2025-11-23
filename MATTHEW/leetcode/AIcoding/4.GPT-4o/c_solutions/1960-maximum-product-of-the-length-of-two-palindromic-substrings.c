int isPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return 0;
        }
        start++;
        end--;
    }
    return 1;
}

int maxProduct(char **words, int wordsSize) {
    int maxProd = 0;
    int palin[wordsSize];

    for (int i = 0; i < wordsSize; i++) {
        palin[i] = isPalindrome(words[i], 0, strlen(words[i]) - 1);
    }

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if (palin[i] && palin[j]) {
                int len1 = strlen(words[i]);
                int len2 = strlen(words[j]);
                maxProd = fmax(maxProd, len1 * len2);
            }
        }
    }

    return maxProd;
}