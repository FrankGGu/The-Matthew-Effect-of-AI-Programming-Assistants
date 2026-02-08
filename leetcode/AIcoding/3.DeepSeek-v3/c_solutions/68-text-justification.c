/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** fullJustify(char ** words, int wordsSize, int maxWidth, int* returnSize){
    char** result = malloc(100 * sizeof(char*));
    *returnSize = 0;
    int i = 0;

    while (i < wordsSize) {
        int j = i, len = 0;
        while (j < wordsSize && len + strlen(words[j]) + (j - i) <= maxWidth) {
            len += strlen(words[j]);
            j++;
        }

        int spaces = maxWidth - len;
        int slots = j - i - 1;

        char* line = malloc((maxWidth + 1) * sizeof(char));
        line[0] = '\0';
        int pos = 0;

        if (j == wordsSize || slots == 0) {
            for (int k = i; k < j; k++) {
                strcpy(line + pos, words[k]);
                pos += strlen(words[k]);
                if (k < j - 1) {
                    line[pos++] = ' ';
                    spaces--;
                }
            }
            while (spaces-- > 0) {
                line[pos++] = ' ';
            }
            line[pos] = '\0';
        } else {
            int base = spaces / slots;
            int extra = spaces % slots;

            for (int k = i; k < j; k++) {
                strcpy(line + pos, words[k]);
                pos += strlen(words[k]);
                if (k < j - 1) {
                    int spaceCount = base + (k - i < extra ? 1 : 0);
                    for (int s = 0; s < spaceCount; s++) {
                        line[pos++] = ' ';
                    }
                }
            }
            line[pos] = '\0';
        }

        result[(*returnSize)++] = line;
        i = j;
    }

    return result;
}