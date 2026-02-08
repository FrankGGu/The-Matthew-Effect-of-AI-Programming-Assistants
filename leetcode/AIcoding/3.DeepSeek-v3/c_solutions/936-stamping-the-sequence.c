/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* movesToStamp(char* stamp, char* target, int* returnSize) {
    int slen = strlen(stamp);
    int tlen = strlen(target);

    int* result = (int*)malloc(tlen * sizeof(int));
    *returnSize = 0;

    char* current = (char*)malloc((tlen + 1) * sizeof(char));
    strcpy(current, target);

    int changed = 1;
    int totalChanged = 0;

    while (changed && totalChanged < tlen) {
        changed = 0;
        for (int i = 0; i <= tlen - slen; i++) {
            int match = 0;
            int allWildcard = 1;

            for (int j = 0; j < slen; j++) {
                if (current[i + j] == '?') {
                    continue;
                }
                allWildcard = 0;
                if (current[i + j] == stamp[j]) {
                    match++;
                } else {
                    match = -1;
                    break;
                }
            }

            if (!allWildcard && match > 0) {
                result[(*returnSize)++] = i;
                for (int j = 0; j < slen; j++) {
                    if (current[i + j] != '?') {
                        current[i + j] = '?';
                        totalChanged++;
                    }
                }
                changed = 1;
            }
        }
    }

    free(current);

    if (totalChanged != tlen) {
        *returnSize = 0;
        return result;
    }

    for (int i = 0; i < *returnSize / 2; i++) {
        int temp = result[i];
        result[i] = result[*returnSize - 1 - i];
        result[*returnSize - 1 - i] = temp;
    }

    return result;
}