/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** substringXorQueries(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize, int** returnColumnSizes) {
    int n = strlen(s);
    int** result = (int**)malloc(queriesSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        (*returnColumnSizes)[i] = 2;
        int first = queries[i][0];
        int second = queries[i][1];
        int target = first ^ second;

        if (target == 0) {
            for (int j = 0; j < n; j++) {
                if (s[j] == '0') {
                    result[i][0] = j;
                    result[i][1] = j;
                    break;
                }
                if (j == n - 1) {
                    result[i][0] = -1;
                    result[i][1] = -1;
                }
            }
            continue;
        }

        char binary[33];
        int len = 0;
        int temp = target;
        while (temp > 0) {
            binary[len++] = (temp & 1) + '0';
            temp >>= 1;
        }

        for (int j = 0; j < len / 2; j++) {
            char tmp = binary[j];
            binary[j] = binary[len - 1 - j];
            binary[len - 1 - j] = tmp;
        }
        binary[len] = '\0';

        char* pos = strstr(s, binary);
        if (pos != NULL) {
            int start = pos - s;
            result[i][0] = start;
            result[i][1] = start + len - 1;
        } else {
            result[i][0] = -1;
            result[i][1] = -1;
        }
    }

    return result;
}