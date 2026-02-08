int countGoodRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    int maxLength = 0, count = 0;
    for (int i = 0; i < rectanglesSize; i++) {
        int side = fmin(rectangles[i][0], rectangles[i][1]);
        if (side > maxLength) {
            maxLength = side;
            count = 1;
        } else if (side == maxLength) {
            count++;
        }
    }
    return count;
}