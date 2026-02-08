int largestOverlap(int** A, int ASize, int* AColSize, int** B, int BSize, int* BColSize) {
    int maxOverlap = 0;
    int n = ASize;

    for (int xShift = -n + 1; xShift < n; xShift++) {
        for (int yShift = -n + 1; yShift < n; yShift++) {
            int overlap = 0;
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (i + xShift >= 0 && i + xShift < n && j + yShift >= 0 && j + yShift < n) {
                        overlap += A[i][j] & B[i + xShift][j + yShift];
                    }
                }
            }
            if (overlap > maxOverlap) {
                maxOverlap = overlap;
            }
        }
    }

    return maxOverlap;
}