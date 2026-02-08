class Solution {
    public boolean isReachableAtTime(int sx, int sy, int tx, int ty, int t) {
        int dx = Math.abs(sx - tx);
        int dy = Math.abs(sy - ty);

        int minTime = Math.max(dx, dy);

        if (minTime == 0) {
            return t != 1;
        } else {
            return t >= minTime;
        }
    }
}