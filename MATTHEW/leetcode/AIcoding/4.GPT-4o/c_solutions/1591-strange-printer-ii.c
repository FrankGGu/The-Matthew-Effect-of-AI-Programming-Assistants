bool isPrintable(int** targetGrid, int targetGridSize, int* targetGridColSize) {
    int colorCount[61] = {0};
    int canPrint[61] = {0};
    int reachable[61] = {0};
    int cnt = 0;

    for (int i = 0; i < targetGridSize; i++) {
        for (int j = 0; j < targetGridColSize[i]; j++) {
            if (targetGrid[i][j] > 0) {
                colorCount[targetGrid[i][j]]++;
                cnt = targetGrid[i][j] > cnt ? targetGrid[i][j] : cnt;
            }
        }
    }

    while (true) {
        bool found = false;
        for (int c = 1; c <= cnt; c++) {
            if (!canPrint[c] && colorCount[c]) {
                int minX = targetGridSize, minY = *targetGridColSize, maxX = -1, maxY = -1;
                for (int i = 0; i < targetGridSize; i++) {
                    for (int j = 0; j < targetGridColSize[i]; j++) {
                        if (targetGrid[i][j] == c) {
                            minX = minX < i ? minX : i;
                            minY = minY < j ? minY : j;
                            maxX = maxX > i ? maxX : i;
                            maxY = maxY > j ? maxY : j;
                        }
                    }
                }
                bool valid = true;
                for (int i = minX; i <= maxX; i++) {
                    for (int j = minY; j <= maxY; j++) {
                        if (targetGrid[i][j] != c && targetGrid[i][j] != 0) {
                            valid = false;
                        }
                    }
                }
                if (valid) {
                    found = true;
                    canPrint[c] = 1;
                    for (int i = minX; i <= maxX; i++) {
                        for (int j = minY; j <= maxY; j++) {
                            if (targetGrid[i][j] == c) {
                                colorCount[c]--;
                                targetGrid[i][j] = 0;
                            }
                        }
                    }
                }
            }
        }
        if (!found) break;
    }

    for (int c = 1; c <= cnt; c++) {
        if (colorCount[c]) return false;
    }
    return true;
}