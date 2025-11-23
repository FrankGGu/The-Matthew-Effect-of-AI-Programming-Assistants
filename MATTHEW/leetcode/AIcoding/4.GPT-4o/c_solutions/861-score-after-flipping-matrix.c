int matrixScore(int** A, int ASize, int* AColSize) {
    int rows = ASize, cols = AColSize[0];
    int score = 0;

    for (int i = 0; i < rows; i++) {
        if (A[i][0] == 0) {
            for (int j = 0; j < cols; j++) {
                A[i][j] ^= 1;
            }
        }
    }

    for (int j = 0; j < cols; j++) {
        int count = 0;
        for (int i = 0; i < rows; i++) {
            if (A[i][j] == 1) {
                count++;
            }
        }
        count = count > rows / 2 ? count : rows - count;
        score += count * (1 << (cols - 1 - j));
    }

    return score;
}