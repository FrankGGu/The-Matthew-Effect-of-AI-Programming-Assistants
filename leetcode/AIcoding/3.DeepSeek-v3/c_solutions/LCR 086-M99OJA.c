/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are stored in *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

bool isPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start++] != s[end--]) {
            return false;
        }
    }
    return true;
}

void backtrack(char *s, int start, int len, char ***result, int *returnSize, int **returnColumnSizes, char **current, int currentSize) {
    if (start == len) {
        result[*returnSize] = (char **)malloc(currentSize * sizeof(char *));
        for (int i = 0; i < currentSize; i++) {
            result[*returnSize][i] = current[i];
        }
        (*returnColumnSizes)[*returnSize] = currentSize;
        (*returnSize)++;
        return;
    }

    for (int end = start; end < len; end++) {
        if (isPalindrome(s, start, end)) {
            int substrLen = end - start + 1;
            char *substr = (char *)malloc((substrLen + 1) * sizeof(char));
            strncpy(substr, s + start, substrLen);
            substr[substrLen] = '\0';
            current[currentSize] = substr;
            backtrack(s, end + 1, len, result, returnSize, returnColumnSizes, current, currentSize + 1);
        }
    }
}

char ***partition(char *s, int *returnSize, int **returnColumnSizes) {
    int len = strlen(s);
    int maxPartitions = 1 << (len - 1);
    char ***result = (char ***)malloc(maxPartitions * sizeof(char **));
    *returnColumnSizes = (int *)malloc(maxPartitions * sizeof(int));
    *returnSize = 0;

    char **current = (char **)malloc(len * sizeof(char *));
    backtrack(s, 0, len, result, returnSize, returnColumnSizes, current, 0);
    free(current);

    return result;
}