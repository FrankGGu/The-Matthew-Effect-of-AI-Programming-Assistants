import java.util.*;

class Solution {
    public boolean isReachable(int sx, int sy, int tx, int ty) {
        while (tx > sx && ty > sy) {
            if (tx > ty) {
                tx -= ty;
            } else {
                ty -= tx;
            }
        }

        if (tx == sx && ty == sy) return true;

        if (tx == sx) {
            return (ty - sy) % sx == 0;
        }

        if (ty == sy) {
            return (tx - sx) % sy == 0;
        }

        return false;
    }
}