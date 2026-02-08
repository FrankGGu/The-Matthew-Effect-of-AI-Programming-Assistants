bool canFormArray(int* arr, int arrSize, int** pieces, int piecesSize, int* piecesColSize){
    int index = 0;
    while (index < arrSize) {
        bool found = false;
        for (int i = 0; i < piecesSize; i++) {
            if (piecesColSize[i] > 0 && arr[index] == pieces[i][0]) {
                for (int j = 0; j < piecesColSize[i]; j++) {
                    if (index >= arrSize || arr[index] != pieces[i][j]) {
                        return false;
                    }
                    index++;
                }
                found = true;
                break;
            }
        }
        if (!found) {
            return false;
        }
    }
    return true;
}