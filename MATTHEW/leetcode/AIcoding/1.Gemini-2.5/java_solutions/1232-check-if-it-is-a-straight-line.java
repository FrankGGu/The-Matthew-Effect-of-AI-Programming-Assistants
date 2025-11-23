class Solution {
    public boolean checkStraightLine(int[][] coordinates) {
        if (coordinates.length <= 2) {
            return true;
        }

        int x0 = coordinates[0][0];
        int y0 = coordinates[0][1];
        int x1 = coordinates[1][0];
        int y1 = coordinates[1][1];

        // Calculate the differences for the first two points
        // These will serve as our reference for the slope (dy/dx)
        // We use cross-multiplication to avoid division and handle vertical lines
        // (y - y0) * (x1 - x0) == (y1 - y0) * (x - x0)
        int dxRef = x1 - x0;
        int dyRef = y1 - y0;

        for (int i = 2; i < coordinates.length; i++) {
            int xi = coordinates[i][0];
            int yi = coordinates[i][1];

            // Check if the current point (xi, yi) maintains the same slope
            // with (x0, y0) as (x1, y0) does with (x0, y0)
            // (yi - y0) * dxRef == dyRef * (xi - x0)
            if ((long)(yi - y0) * dxRef != (long)dyRef * (xi - x0)) {
                return false;
            }
        }

        return true;
    }
}