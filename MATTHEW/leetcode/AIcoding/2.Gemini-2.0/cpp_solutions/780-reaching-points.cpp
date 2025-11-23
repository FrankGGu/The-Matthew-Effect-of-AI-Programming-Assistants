class Solution {
public:
    bool reachingPoints(int sx, int sy, int tx, int ty) {
        while (tx >= sx && ty >= sy) {
            if (tx == sx && ty == sy) return true;
            if (tx > ty) {
                if (ty == sy) {
                    if ((tx - sx) % ty == 0) return true;
                    else return false;
                }
                tx %= ty;
            } else {
                if (tx == sx) {
                    if ((ty - sy) % tx == 0) return true;
                    else return false;
                }
                ty %= tx;
            }
        }
        return false;
    }
};