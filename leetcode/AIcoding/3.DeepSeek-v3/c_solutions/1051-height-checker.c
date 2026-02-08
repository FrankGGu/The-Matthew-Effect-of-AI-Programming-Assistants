int heightChecker(int* heights, int heightsSize) {
    int expected[heightsSize];
    for (int i = 0; i < heightsSize; i++) {
        expected[i] = heights[i];
    }

    for (int i = 0; i < heightsSize - 1; i++) {
        for (int j = 0; j < heightsSize - i - 1; j++) {
            if (expected[j] > expected[j + 1]) {
                int temp = expected[j];
                expected[j] = expected[j + 1];
                expected[j + 1] = temp;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < heightsSize; i++) {
        if (heights[i] != expected[i]) {
            count++;
        }
    }

    return count;
}