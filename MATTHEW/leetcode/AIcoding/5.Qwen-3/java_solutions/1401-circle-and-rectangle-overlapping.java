public class Solution {
    public boolean checkOverlap(int radius, int xCenter1, int yCenter1, int xCenter2, int yCenter2, int xCorner2, int yCorner2) {
        int xClosest = Math.max(xCenter2, Math.min(xCenter1, xCorner2));
        int yClosest = Math.max(yCenter2, Math.min(yCenter1, yCorner2));

        int dx = xCenter1 - xClosest;
        int dy = yCenter1 - yClosest;

        return (dx * dx + dy * dy) <= radius * radius;
    }
}