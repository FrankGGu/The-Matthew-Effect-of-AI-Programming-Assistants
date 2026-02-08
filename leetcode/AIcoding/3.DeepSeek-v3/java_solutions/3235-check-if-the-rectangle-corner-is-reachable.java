class Solution {
    public boolean isReachable(int targetX, int targetY) {
        while (targetX > 1 && targetY > 1) {
            if (targetX > targetY) {
                targetX %= targetY;
            } else {
                targetY %= targetX;
            }
        }
        if (targetX == 1 || targetY == 1) {
            return true;
        }
        return (targetX == targetY && targetX == 1);
    }
}