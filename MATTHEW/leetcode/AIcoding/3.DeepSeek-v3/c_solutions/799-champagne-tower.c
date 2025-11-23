double champagneTower(int poured, int query_row, int query_glass) {
    double tower[101][101] = {0.0};
    tower[0][0] = (double)poured;

    for (int row = 0; row <= query_row; row++) {
        for (int col = 0; col <= row; col++) {
            double overflow = (tower[row][col] - 1.0) / 2.0;
            if (overflow > 0) {
                tower[row + 1][col] += overflow;
                tower[row + 1][col + 1] += overflow;
            }
        }
    }

    return tower[query_row][query_glass] > 1.0 ? 1.0 : tower[query_row][query_glass];
}