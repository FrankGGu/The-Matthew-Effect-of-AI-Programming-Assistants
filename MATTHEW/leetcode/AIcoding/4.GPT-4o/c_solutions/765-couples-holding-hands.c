int minSwapsCouples(int* row, int rowSize) {
    int pos[rowSize / 2];
    for (int i = 0; i < rowSize; i++) {
        pos[row[i] / 2] = i;
    }

    int swaps = 0;
    for (int i = 0; i < rowSize; i += 2) {
        int couple = row[i] ^ 1;
        if (row[i + 1] != couple) {
            swaps++;
            int couplePos = pos[couple];
            pos[row[i + 1] / 2] = couplePos;
            row[couplePos] = row[i + 1];
            row[i + 1] = couple;
        }
    }

    return swaps;
}