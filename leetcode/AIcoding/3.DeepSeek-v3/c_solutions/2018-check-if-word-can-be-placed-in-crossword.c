bool placeWordInCrossword(char** board, int boardSize, int* boardColSize, char* word) {
    int m = boardSize;
    int n = boardColSize[0];
    int len = strlen(word);

    // Check horizontally
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (board[i][j] == '#') continue;

            // Check left to right
            int k = 0;
            int col = j;
            while (col < n && board[i][col] != '#' && k < len) {
                if (board[i][col] != ' ' && board[i][col] != word[k]) break;
                k++;
                col++;
            }
            if (k == len && (col == n || board[i][col] == '#')) {
                return true;
            }

            // Check right to left
            k = 0;
            col = j;
            while (col < n && board[i][col] != '#' && k < len) {
                if (board[i][col] != ' ' && board[i][col] != word[len - 1 - k]) break;
                k++;
                col++;
            }
            if (k == len && (col == n || board[i][col] == '#')) {
                return true;
            }
        }
    }

    // Check vertically
    for (int j = 0; j < n; j++) {
        for (int i = 0; i < m; i++) {
            if (board[i][j] == '#') continue;

            // Check top to bottom
            int k = 0;
            int row = i;
            while (row < m && board[row][j] != '#' && k < len) {
                if (board[row][j] != ' ' && board[row][j] != word[k]) break;
                k++;
                row++;
            }
            if (k == len && (row == m || board[row][j] == '#')) {
                return true;
            }

            // Check bottom to top
            k = 0;
            row = i;
            while (row < m && board[row][j] != '#' && k < len) {
                if (board[row][j] != ' ' && board[row][j] != word[len - 1 - k]) break;
                k++;
                row++;
            }
            if (k == len && (row == m || board[row][j] == '#')) {
                return true;
            }
        }
    }

    return false;
}