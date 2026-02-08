int beautifulTowers(int* heights, int heightsSize) {
    int count = 0;
    for (int i = 0; i < heightsSize; i++) {
        int left = (i > 0) ? heights[i - 1] : 0;
        int right = (i < heightsSize - 1) ? heights[i + 1] : 0;
        if (heights[i] > left && heights[i] > right) {
            count++;
        }
    }
    return count;
}