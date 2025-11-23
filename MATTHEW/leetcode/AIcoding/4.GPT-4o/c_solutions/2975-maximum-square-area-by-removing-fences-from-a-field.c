int maxSquareArea(int* heights, int heightsSize) {
    int maxArea = 0;
    for (int i = 0; i < heightsSize; i++) {
        for (int j = i; j < heightsSize; j++) {
            int minHeight = heights[i];
            for (int k = i; k <= j; k++) {
                if (heights[k] < minHeight) {
                    minHeight = heights[k];
                }
            }
            int sideLength = j - i + 1;
            if (sideLength <= minHeight) {
                int area = sideLength * sideLength;
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }
    return maxArea;
}