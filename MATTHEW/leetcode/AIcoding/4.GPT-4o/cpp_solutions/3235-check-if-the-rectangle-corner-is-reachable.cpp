class Solution {
public:
    bool isReachable(int x, int y, int x1, int y1) {
        return (x1 - x) % 2 == (y1 - y) % 2 && abs(x1 - x) <= abs(y1 - y);
    }
};