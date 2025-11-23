class Solution {
public:
    bool isReachable(int x, int y) {
        while (x > 0 && y > 0) {
            if (x > y) {
                x %= y;
            } else {
                y %= x;
            }
        }
        return (x == 0 && y % 3 == 0) || (y == 0 && x % 3 == 0);
    }
};