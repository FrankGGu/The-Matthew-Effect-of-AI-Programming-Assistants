int largestOverlap(int** img1, int img1Size, int* img1ColSize, int** img2, int img2Size, int* img2ColSize) {
    int n = img1Size;
    int maxOverlap = 0;

    for (int di = -n + 1; di < n; di++) {
        for (int dj = -n + 1; dj < n; dj++) {
            int overlap = 0;
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    int ni = i + di;
                    int nj = j + dj;
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                        if (img1[i][j] == 1 && img2[ni][nj] == 1) {
                            overlap++;
                        }
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