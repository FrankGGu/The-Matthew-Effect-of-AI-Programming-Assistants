bool isCovered(int** ranges, int rangesSize, int* rangesColSize, int left, int right) {
    int covered[51] = {0};

    for (int i = 0; i < rangesSize; i++) {
        int start = ranges[i][0];
        int end = ranges[i][1];
        for (int j = start; j <= end; j++) {
            if (j >= left && j <= right) {
                covered[j - left] = 1;
            }
        }
    }

    for (int i = left; i <= right; i++) {
        if (covered[i - left] == 0) {
            return false;
        }
    }

    return true;
}