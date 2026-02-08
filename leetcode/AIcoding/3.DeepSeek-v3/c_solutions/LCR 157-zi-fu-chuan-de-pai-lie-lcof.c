/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** combination(char* s, int* returnSize) {
    int len = strlen(s);
    int n = 1 << len;
    *returnSize = 0;
    char** result = (char**)malloc(n * sizeof(char*));

    for (int i = 0; i < n; i++) {
        char* combination = (char*)malloc((len + 1) * sizeof(char));
        int idx = 0;

        for (int j = 0; j < len; j++) {
            if (i & (1 << j)) {
                combination[idx++] = s[j];
            }
        }
        combination[idx] = '\0';
        result[(*returnSize)++] = combination;
    }

    return result;
}