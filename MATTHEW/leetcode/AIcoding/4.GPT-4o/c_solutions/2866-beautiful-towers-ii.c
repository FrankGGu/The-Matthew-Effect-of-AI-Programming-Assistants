int beautifulTowers(int* heights, int heightsSize) {
    int max_height = 0, count = 0;
    for (int i = 0; i < heightsSize; i++) {
        if (heights[i] > max_height) {
            max_height = heights[i];
            count++;
        }
    }
    return count;
}