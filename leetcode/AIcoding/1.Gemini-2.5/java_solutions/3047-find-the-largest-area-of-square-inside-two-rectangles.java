class Solution {
    public long largestSquareArea(int[][] rectangles) {
        // Extract coordinates of the first rectangle
        int x1 = rectangles[0][0];
        int y1 = rectangles[0][1];
        int x2 = rectangles[0][2];
        int y2 = rectangles[0][3];

        // Extract coordinates of the second rectangle
        int x3 = rectangles[1][0];
        int y3 = rectangles[1][1];
        int x4 = rectangles[1][2];
        int y4 = rectangles[1][3];

        // Calculate the coordinates of the intersection rectangle
        // The bottom-left corner of the intersection
        int intersectX1 = Math.max(x1, x3);
        int intersectY1 = Math.max(y1, y3);

        // The top-right corner of the intersection
        int intersectX2 = Math.min(x2, x4);
        int intersectY2 = Math.min(y2, y4);

        // Check if there is a valid intersection rectangle
        // If intersectX1 >= intersectX2 or intersectY1 >= intersectY2,
        // the rectangles do not overlap or overlap only at a line/point,
        // so no square can be formed.
        if (intersectX1 >= intersectX2 || intersectY1 >= intersectY2) {
            return 0;
        }

        // Calculate the width and height of the intersection rectangle
        int width = intersectX2 - intersectX1;
        int height = intersectY2 - intersectY1;

        // The side length of the largest square that can fit inside the
        // intersection rectangle is the minimum of its width and height.
        int side = Math.min(width, height);

        // The area of this square is side * side.
        // Cast one of the operands to long to ensure the multiplication is done using long arithmetic
        return (long)side * side;
    }
}