bool isCovered(int** ranges, int rangesSize, int* rangesColSize, int left, int right) {
    bool covered[51] = {false}; 

    for (int i = 0; i < rangesSize; i++) {
        int start = ranges[i][0];
        int end = ranges[i][1];
        for (int j = start; j <= end; j++) {
            if (j >= 1 && j <= 50) { 
                covered[j] = true;
            }
        }
    }

    for (int i = left; i <= right; i++) {
        if (!covered[i]) {
            return false;
        }
    }

    return true;
}