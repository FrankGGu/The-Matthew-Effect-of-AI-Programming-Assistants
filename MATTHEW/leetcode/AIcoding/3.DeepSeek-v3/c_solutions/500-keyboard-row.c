/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** findWords(char** words, int wordsSize, int* returnSize) {
    int rows[26] = {2,3,3,2,1,2,2,2,1,2,2,2,3,3,1,1,1,1,2,1,1,3,1,3,1,3};
    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        if (len == 0) continue;

        int row = rows[tolower(word[0]) - 'a'];
        int valid = 1;

        for (int j = 1; j < len; j++) {
            if (rows[tolower(word[j]) - 'a'] != row) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            result[*returnSize] = (char*)malloc((len + 1) * sizeof(char));
            strcpy(result[*returnSize], word);
            (*returnSize)++;
        }
    }

    return result;
}