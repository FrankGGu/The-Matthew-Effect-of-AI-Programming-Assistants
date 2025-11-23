bool isBoomerang(int** points, int pointsSize, int* pointsColSize) {
    int x1 = points[0][0];
    int y1 = points[0][1];
    int x2 = points[1][0];
    int y2 = points[1][1];
    int x3 = points[2][0];
    int y3 = points[2][1];

    // Check for distinct points
    if ((x1 == x2 && y1 == y2) ||
        (x1 == x3 && y1 == y3) ||
        (x2 == x3 && y2 == y3)) {
        return false;
    }

    // Check for collinearity using the slope formula or cross product
    // Three points (x1, y1), (x2, y2), (x3, y3) are collinear if
    // (y2 - y1) * (x3 - x2) == (y3 - y2) * (x2 - x1)
    // This is equivalent to checking if the area of the triangle formed by them is zero.
    // Area = 0.5 * |x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2)|
    // So, we check if x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2) == 0
    return (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) != 0;
}