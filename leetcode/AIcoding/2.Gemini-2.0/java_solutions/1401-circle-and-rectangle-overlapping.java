class Solution {
    public boolean checkOverlap(int radius, int x_center, int y_center, int x1, int y1, int x2, int y2) {
        double closestX = x_center;
        double closestY = y_center;

        if (x_center < x1) {
            closestX = x1;
        } else if (x_center > x2) {
            closestX = x2;
        }

        if (y_center < y1) {
            closestY = y1;
        } else if (y_center > y2) {
            closestY = y2;
        }

        double distance = Math.sqrt(Math.pow(x_center - closestX, 2) + Math.pow(y_center - closestY, 2));

        return distance <= radius;
    }
}