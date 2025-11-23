#include <stdlib.h>

char **cellsInRange(char *s, int *returnSize) {
    char startCol = s[0];
    char startRow = s[1];
    char endCol = s[3];
    char endRow = s[4];

    int numCols = endCol - startCol + 1;
    int numRows = endRow - startRow + 1;

    *returnSize = numCols * numRows;

    char **result = (char **)malloc(*returnSize * sizeof(char *));

    int currentIdx = 0;
    for (char c = startCol; c <= endCol; c++) {
        for (char r = startRow; r <= endRow; r++) {
            result[currentIdx] = (char *)malloc(sizeof(char) * 3);
            result[currentIdx][0] = c;
            result[currentIdx][1] = r;
            result[currentIdx][2] = '\0';
            currentIdx++;
        }
    }

    return result;
}