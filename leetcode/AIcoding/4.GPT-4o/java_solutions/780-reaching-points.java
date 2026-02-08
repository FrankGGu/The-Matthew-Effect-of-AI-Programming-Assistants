class Solution {
    public boolean reachingPoints(int sx, int sy, int tx, int ty) {
        while (tx >= sx && ty >= sy) {
            if (tx == sx && ty == sy) return true;
            if (tx > ty) {
                tx -= (tx - sx) / (ty / sy + 1) * (ty / sy + 1);
            } else {
                ty -= (ty - sy) / (tx / sx + 1) * (tx / sx + 1);
            }
        }
        return sx == tx && sy <= ty && (ty - sy) % sx == 0 || sy == ty && sx <= tx && (tx - sx) % sy == 0;
    }
}