bool canFormArray(int* arr, int arrSize, int** pieces, int piecesSize, int* piecesColSize) {
    int map[101];
    for (int i = 0; i < 101; i++) {
        map[i] = -1;
    }

    for (int i = 0; i < piecesSize; i++) {
        map[pieces[i][0]] = i;
    }

    int i = 0;
    while (i < arrSize) {
        int idx = map[arr[i]];
        if (idx == -1) return false;

        for (int j = 0; j < piecesColSize[idx]; j++) {
            if (arr[i + j] != pieces[idx][j]) {
                return false;
            }
        }
        i += piecesColSize[idx];
    }

    return true;
}