public class Solution {
    public boolean isReachable(int sx, int sy, int dx, int dy) {
        if (sx == dx && sy == dy) {
            return true;
        }
        if (dx < sx || dy < sy) {
            return false;
        }
        if ((dx - sx) % 2 != (dy - sy) % 2) {
            return false;
        }
        return true;
    }
}