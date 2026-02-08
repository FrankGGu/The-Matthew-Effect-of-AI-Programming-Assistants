char** cellsInRange(char * s, int* returnSize) {
    char **result;
    int startCol = s[0] - 'A';
    int endCol = s[3] - 'A';
    int startRow = s[1] - '0';
    int endRow = s[4] - '0';

    *returnSize = (endCol - startCol + 1) * (endRow - startRow + 1);
    result = (char**)malloc(*returnSize * sizeof(char*));

    int index = 0;
    for (int col = startCol; col <= endCol; col++) {
        for (int row = startRow; row <= endRow; row++) {
            result[index] = (char*)malloc(3 * sizeof(char));
            sprintf(result[index], "%c%d", col + 'A', row);
            index++;
        }
    }

    return result;
}