class Solution {
public:
    bool isReachableAtTime(int sx, int sy, int fx, int fy, int t) {
        int dx = abs(fx - sx);
        int dy = abs(fy - sy);
        int min_time = max(dx, dy);
        if (min_time == 0) {
            return t != 1;
        }
        return t >= min_time;
    }
};