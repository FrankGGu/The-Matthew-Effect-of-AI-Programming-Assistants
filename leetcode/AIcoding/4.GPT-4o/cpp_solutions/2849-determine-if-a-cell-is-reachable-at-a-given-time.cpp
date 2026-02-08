class Solution {
public:
    bool isReachable(int x, int y, int time) {
        int distance = abs(x) + abs(y);
        return distance <= time && (time - distance) % 2 == 0;
    }
};