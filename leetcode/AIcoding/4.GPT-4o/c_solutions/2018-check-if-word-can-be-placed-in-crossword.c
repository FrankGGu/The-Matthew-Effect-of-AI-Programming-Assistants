bool canPlaceWordInCrossword(char** board, int boardSize, int* boardColSize, char* word) {
    int len = strlen(word);

    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[i]; j++) {
            if (j + len <= boardColSize[i]) {
                bool canPlace = true;
                for (int k = 0; k < len; k++) {
                    if (board[i][j + k] != ' ' && board[i][j + k] != word[k]) {
                        canPlace = false;
                        break;
                    }
                }
                if (canPlace && (j == 0 || board[i][j - 1] == '#') && (j + len == boardColSize[i] || board[i][j + len] == '#')) {
                    return true;
                }
            }

            if (i + len <= boardSize) {
                bool canPlace = true;
                for (int k = 0; k < len; k++) {
                    if (board[i + k][j] != ' ' && board[i + k][j] != word[k]) {
                        canPlace = false;
                        break;
                    }
                }
                if (canPlace && (i == 0 || board[i - 1][j] == '#') && (i + len == boardSize || board[i + len][j] == '#')) {
                    return true;
                }
            }
        }
    }
    return false;
}