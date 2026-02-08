int largestSquareArea(int** bottomLeft, int bottomLeftSize, int* bottomLeftColSize, int** topRight, int topRightSize, int* topRightColSize) {
    int n = bottomLeftSize;
    if (n == 0) return 0;

    long long maxArea = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int x1 = bottomLeft[i][0];
            int y1 = bottomLeft[i][1];
            int x2 = topRight[i][0];
            int y2 = topRight[i][1];

            int x3 = bottomLeft[j][0];
            int y3 = bottomLeft[j][1];
            int x4 = topRight[j][0];
            int y4 = topRight[j][1];

            int left = (x1 > x3) ? x1 : x3;
            int right = (x2 < x4) ? x2 : x4;
            int bottom = (y1 > y3) ? y1 : y3;
            int top = (y2 < y4) ? y2 : y4;

            if (left < right && bottom < top) {
                int side = (right - left) < (top - bottom) ? (right - left) : (top - bottom);
                long long area = (long long)side * side;
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }

    return maxArea;
}