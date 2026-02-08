char** rotateTheBox(char** box, int boxSize, int* boxColSize, int* returnSize) {
    int newColSize = boxSize;
    int newRowSize = *boxColSize;
    char** rotatedBox = (char**)malloc(newColSize * sizeof(char*));
    for (int i = 0; i < newColSize; i++) {
        rotatedBox[i] = (char*)malloc(newRowSize + 1);
    }

    for (int j = 0; j < newRowSize; j++) {
        int emptyCount = 0;
        for (int i = boxSize - 1; i >= 0; i--) {
            if (box[i][j] == '#') {
                rotatedBox[j][boxSize - 1 - emptyCount] = '#';
                emptyCount++;
            } else if (box[i][j] == '*') {
                for (int k = 0; k < emptyCount; k++) {
                    rotatedBox[j][boxSize - 1 - k] = '.';
                }
                rotatedBox[j][boxSize - 1 - emptyCount] = '*';
                emptyCount = 0;
            }
        }
        for (int k = 0; k < emptyCount; k++) {
            rotatedBox[j][boxSize - 1 - k] = '.';
        }
        rotatedBox[j][newColSize] = '\0';
    }

    *returnSize = newColSize;
    return rotatedBox;
}