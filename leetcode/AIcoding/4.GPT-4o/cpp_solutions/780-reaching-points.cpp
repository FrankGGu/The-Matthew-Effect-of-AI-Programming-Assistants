class Solution {
public:
    bool canReach(int x, int y, int targetX, int targetY) {
        while (targetX > x && targetY > y) {
            if (targetX > targetY) {
                targetX -= targetY;
            } else {
                targetY -= targetX;
            }
        }
        return (targetX == x && (targetY - y) % x == 0) || 
               (targetY == y && (targetX - x) % y == 0);
    }
};