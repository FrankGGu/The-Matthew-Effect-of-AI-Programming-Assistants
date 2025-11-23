bool isCovered(int** ranges, int rangesSize, int* rangesColSize, int left, int right) {
    bool covered[52] = {false};
    for (int i = 0; i < rangesSize; i++) {
        for (int j = ranges[i][0]; j <= ranges[i][1]; j++) {
            covered[j] = true;
        }
    }
    for (int i = left; i <= right; i++) {
        if (!covered[i]) {
            return false;
        }
    }
    return true;
}