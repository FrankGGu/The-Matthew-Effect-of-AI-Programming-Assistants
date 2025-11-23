/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** ambiguousCoordinates(char * s, int* returnSize) {
    int len = strlen(s);
    char **res = malloc(1000 * sizeof(char *));
    *returnSize = 0;

    for (int i = 2; i < len - 1; i++) {
        char *left = malloc(i + 1);
        char *right = malloc(len - i + 1);

        strncpy(left, s + 1, i - 1);
        left[i - 1] = '\0';

        strncpy(right, s + i, len - i - 1);
        right[len - i - 1] = '\0';

        int leftLen = strlen(left);
        int rightLen = strlen(right);

        char **leftParts = malloc(20 * sizeof(char *));
        int leftCount = 0;
        char **rightParts = malloc(20 * sizeof(char *));
        int rightCount = 0;

        for (int j = 1; j <= leftLen; j++) {
            char *intPart = malloc(j + 1);
            strncpy(intPart, left, j);
            intPart[j] = '\0';

            char *fracPart = malloc(leftLen - j + 1);
            if (j < leftLen) {
                strncpy(fracPart, left + j, leftLen - j);
                fracPart[leftLen - j] = '\0';
            } else {
                fracPart[0] = '\0';
            }

            if ((intPart[0] != '0' || j == 1) && (fracPart[0] == '\0' || fracPart[strlen(fracPart) - 1] != '0')) {
                char *part = malloc(leftLen + 2);
                if (fracPart[0] == '\0') {
                    strcpy(part, intPart);
                } else {
                    sprintf(part, "%s.%s", intPart, fracPart);
                }
                leftParts[leftCount++] = part;
            }

            free(intPart);
            free(fracPart);
        }

        for (int j = 1; j <= rightLen; j++) {
            char *intPart = malloc(j + 1);
            strncpy(intPart, right, j);
            intPart[j] = '\0';

            char *fracPart = malloc(rightLen - j + 1);
            if (j < rightLen) {
                strncpy(fracPart, right + j, rightLen - j);
                fracPart[rightLen - j] = '\0';
            } else {
                fracPart[0] = '\0';
            }

            if ((intPart[0] != '0' || j == 1) && (fracPart[0] == '\0' || fracPart[strlen(fracPart) - 1] != '0')) {
                char *part = malloc(rightLen + 2);
                if (fracPart[0] == '\0') {
                    strcpy(part, intPart);
                } else {
                    sprintf(part, "%s.%s", intPart, fracPart);
                }
                rightParts[rightCount++] = part;
            }

            free(intPart);
            free(fracPart);
        }

        for (int l = 0; l < leftCount; l++) {
            for (int r = 0; r < rightCount; r++) {
                char *coord = malloc(leftLen + rightLen + 6);
                sprintf(coord, "(%s, %s)", leftParts[l], rightParts[r]);
                res[(*returnSize)++] = coord;
            }
        }

        for (int l = 0; l < leftCount; l++) free(leftParts[l]);
        for (int r = 0; r < rightCount; r++) free(rightParts[r]);
        free(leftParts);
        free(rightParts);
        free(left);
        free(right);
    }

    return res;
}