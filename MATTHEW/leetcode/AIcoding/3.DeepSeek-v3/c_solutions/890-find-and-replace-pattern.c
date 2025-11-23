/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** findAndReplacePattern(char ** words, int wordsSize, char * pattern, int* returnSize){
    *returnSize = 0;
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    int patternLen = strlen(pattern);

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int wordLen = strlen(word);

        if (wordLen != patternLen) {
            continue;
        }

        char map[26] = {0};
        char used[26] = {0};
        int valid = 1;

        for (int j = 0; j < patternLen; j++) {
            char p = pattern[j] - 'a';
            char w = word[j] - 'a';

            if (map[p] == 0) {
                if (used[w]) {
                    valid = 0;
                    break;
                }
                map[p] = word[j];
                used[w] = 1;
            } else {
                if (map[p] != word[j]) {
                    valid = 0;
                    break;
                }
            }
        }

        if (valid) {
            result[*returnSize] = (char *)malloc((patternLen + 1) * sizeof(char));
            strcpy(result[*returnSize], word);
            (*returnSize)++;
        }
    }

    return result;
}