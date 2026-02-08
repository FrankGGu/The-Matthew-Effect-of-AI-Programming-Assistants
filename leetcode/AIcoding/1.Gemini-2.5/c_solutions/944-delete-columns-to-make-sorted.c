int minDeletionSize(char **strs, int strsSize) {
    if (strsSize == 0) {
        return 0;
    }
    int numRows = strsSize;
    int numCols = strlen(strs[0]);
    int deletedColumns = 0;

    for (int j = 0; j < numCols; j++) {
        for (int i = 0; i < numRows - 1; i++) {
            if (strs[i][j] > strs[i+1][j]) {
                deletedColumns++;
                break;
            }
        }
    }
    return deletedColumns;
}