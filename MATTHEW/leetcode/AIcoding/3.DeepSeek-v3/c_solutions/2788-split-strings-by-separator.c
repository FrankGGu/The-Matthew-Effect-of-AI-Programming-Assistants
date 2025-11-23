/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** splitWordsBySeparator(char ** words, int wordsSize, char separator, int* returnSize) {
    char **result = malloc(1000 * sizeof(char *));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int len = strlen(word);
        int start = 0;

        for (int j = 0; j <= len; j++) {
            if (word[j] == separator || word[j] == '\0') {
                if (j > start) {
                    int substr_len = j - start;
                    char *substr = malloc((substr_len + 1) * sizeof(char));
                    strncpy(substr, word + start, substr_len);
                    substr[substr_len] = '\0';
                    result[(*returnSize)++] = substr;
                }
                start = j + 1;
            }
        }
    }

    return result;
}