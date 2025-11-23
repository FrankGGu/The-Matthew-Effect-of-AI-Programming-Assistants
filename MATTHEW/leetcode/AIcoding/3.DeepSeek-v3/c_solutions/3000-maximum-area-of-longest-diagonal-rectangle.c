int areaOfMaxDiagonal(int** dimensions, int dimensionsSize, int* dimensionsColSize) {
    int maxDiagonalSq = 0;
    int maxArea = 0;

    for (int i = 0; i < dimensionsSize; i++) {
        int length = dimensions[i][0];
        int width = dimensions[i][1];
        int diagonalSq = length * length + width * width;

        if (diagonalSq > maxDiagonalSq) {
            maxDiagonalSq = diagonalSq;
            maxArea = length * width;
        } else if (diagonalSq == maxDiagonalSq) {
            int area = length * width;
            if (area > maxArea) {
                maxArea = area;
            }
        }
    }

    return maxArea;
}