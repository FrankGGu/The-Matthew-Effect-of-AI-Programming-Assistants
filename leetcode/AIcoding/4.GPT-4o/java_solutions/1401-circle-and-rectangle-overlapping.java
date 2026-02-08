public class Solution {
    public boolean checkOverlap(int circleX, int circleY, int radius, int rectX1, int rectY1, int rectX2, int rectY2) {
        int closestX = Math.max(rectX1, Math.min(circleX, rectX2));
        int closestY = Math.max(rectY1, Math.min(circleY, rectY2));
        int distanceX = circleX - closestX;
        int distanceY = circleY - closestY;
        return (distanceX * distanceX + distanceY * distanceY) < (radius * radius);
    }
}