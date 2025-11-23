class Solution {
    public boolean checkOverlap(int radius, int x_center, int y_center, int x1, int y1, int x2, int y2) {

        int closestX = Math.max(x1, Math.min(x_center, x2));
        int closestY = Math.max(y1, Math.min(y_center, y2));

        int distX = x_center - closestX;
        int distY = y_center - closestY;

        return (distX * distX + distY * distY) <= (radius * radius);
    }
}