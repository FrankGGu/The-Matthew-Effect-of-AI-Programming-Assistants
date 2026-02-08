class Solution {
    public boolean isReachableAtTime(int sx, int sy, int fx, int fy, int t) {
        int dx = Math.abs(sx - fx);
        int dy = Math.abs(sy - fy);
        int minTime = Math.max(dx, dy);

        if (minTime == 0) {
            return t != 1;
        }

        return t >= minTime;
    }
}