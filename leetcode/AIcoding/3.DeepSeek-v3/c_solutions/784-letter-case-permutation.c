/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** letterCasePermutation(char* s, int* returnSize) {
    int len = strlen(s);
    int count = 0;

    for (int i = 0; i < len; i++) {
        if (isalpha(s[i])) {
            count++;
        }
    }

    int total = 1 << count;
    *returnSize = total;

    char** result = (char**)malloc(total * sizeof(char*));
    for (int i = 0; i < total; i++) {
        result[i] = (char*)malloc((len + 1) * sizeof(char));
        strcpy(result[i], s);

        int bit = 0;
        for (int j = 0; j < len; j++) {
            if (isalpha(s[j])) {
                if (i & (1 << bit)) {
                    if (islower(result[i][j])) {
                        result[i][j] = toupper(result[i][j]);
                    } else {
                        result[i][j] = tolower(result[i][j]);
                    }
                }
                bit++;
            }
        }
    }

    return result;
}