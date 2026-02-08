/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** uncommonFromSentences(char* s1, char* s2, int* returnSize) {
    char* words[200];
    int count = 0;
    char temp[201];

    strcpy(temp, s1);
    strcat(temp, " ");
    strcat(temp, s2);

    char* token = strtok(temp, " ");
    while (token != NULL) {
        words[count++] = token;
        token = strtok(NULL, " ");
    }

    char** result = (char**)malloc(count * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < count; i++) {
        int freq = 0;
        for (int j = 0; j < count; j++) {
            if (strcmp(words[i], words[j]) == 0) {
                freq++;
            }
        }
        if (freq == 1) {
            result[*returnSize] = (char*)malloc((strlen(words[i]) + 1) * sizeof(char));
            strcpy(result[*returnSize], words[i]);
            (*returnSize)++;
        }
    }

    return result;
}