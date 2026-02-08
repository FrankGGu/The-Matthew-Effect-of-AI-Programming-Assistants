class Solution {
    public boolean isReachableAtTime(int sx, int sy, int fx, int fy, int t) {
        int dx = Math.abs(fx - sx);
        int dy = Math.abs(fy - sy);
        if (dx == 0 && dy == 0) {
            return t != 1;
        }
        int minTime = Math.max(dx, dy);
        return t >= minTime;
    }
}