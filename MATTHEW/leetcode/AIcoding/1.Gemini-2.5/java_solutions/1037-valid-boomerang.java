class Solution {
    public boolean isBoomerang(int[][] points) {
        int x1 = points[0][0];
        int y1 = points[0][1];
        int x2 = points[1][0];
        int y2 = points[1][1];
        int x3 = points[2][0];
        int y3 = points[2][1];

        // Check if all three points are distinct
        // (x1 == x2 && y1 == y2) means P1 and P2 are the same point
        if ((x1 == x2 && y1 == y2) || 
            (x1 == x3 && y1 == y3) || 
            (x2 == x3 && y2 == y3)) {
            return false;
        }

        // Check if the three points are collinear
        // The area of the triangle formed by (x1, y1), (x2, y2), (x3, y3) is 0.5 * |x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2)|
        // If the expression inside the absolute value is 0, they are collinear.
        return (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) != 0;
    }
}