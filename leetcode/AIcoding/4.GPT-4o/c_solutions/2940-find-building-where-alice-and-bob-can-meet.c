int findBuilding(int* heights, int heightsSize) {
    int leftMax = 0, rightMax = 0;
    int result = -1;

    for (int i = 0; i < heightsSize; i++) {
        if (heights[i] > leftMax) {
            leftMax = heights[i];
        }
        if (heights[heightsSize - 1 - i] > rightMax) {
            rightMax = heights[heightsSize - 1 - i];
        }
        if (leftMax == rightMax && leftMax > 0) {
            result = i + 1;
        }
    }

    return result == -1 ? -1 : result;
}