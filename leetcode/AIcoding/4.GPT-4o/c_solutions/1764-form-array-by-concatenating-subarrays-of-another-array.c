bool canFormArray(int* arr, int arrSize, int** pieces, int piecesSize, int* piecesColSize) {
    int* index = (int*)calloc(101, sizeof(int));
    for (int i = 0; i < piecesSize; i++) {
        index[pieces[i][0]] = i + 1;
    }

    for (int i = 0; i < arrSize; ) {
        if (index[arr[i]] == 0) return false;
        int j = index[arr[i]] - 1;
        for (int k = 0; k < pieces[j][0]; k++) {
            if (i + k >= arrSize || arr[i + k] != pieces[j][k]) {
                free(index);
                return false;
            }
        }
        i += pieces[j][0];
    }

    free(index);
    return true;
}