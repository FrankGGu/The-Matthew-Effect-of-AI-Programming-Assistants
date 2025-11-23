int countPrefixSuffixPairs(char** words, int wordsSize) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            char* word1 = words[i];
            char* word2 = words[j];
            int len1 = strlen(word1);
            int len2 = strlen(word2);

            if (len1 > len2) continue;

            int isPrefix = 1;
            int isSuffix = 1;

            for (int k = 0; k < len1; k++) {
                if (word1[k] != word2[k]) {
                    isPrefix = 0;
                    break;
                }
            }

            for (int k = 0; k < len1; k++) {
                if (word1[k] != word2[len2 - len1 + k]) {
                    isSuffix = 0;
                    break;
                }
            }

            if (isPrefix && isSuffix) {
                count++;
            }
        }
    }
    return count;
}