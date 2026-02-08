int numberOfBeams(char **bank, int bankSize) {
    int totalBeams = 0;
    int prevRowCount = 0;

    for (int i = 0; i < bankSize; i++) {
        int currentRowCount = 0;
        for (int j = 0; bank[i][j] != '\0'; j++) {
            if (bank[i][j] == '1') {
                currentRowCount++;
            }
        }

        if (currentRowCount > 0) {
            if (prevRowCount > 0) {
                totalBeams += prevRowCount * currentRowCount;
            }
            prevRowCount = currentRowCount;
        }
    }

    return totalBeams;
}