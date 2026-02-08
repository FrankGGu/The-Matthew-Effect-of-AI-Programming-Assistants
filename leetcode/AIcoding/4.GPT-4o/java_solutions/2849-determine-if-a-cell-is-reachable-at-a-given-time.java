class Solution {
    public boolean isReachable(int x, int y, int t) {
        int distance = Math.abs(x) + Math.abs(y);
        return distance <= t && (t - distance) % 2 == 0;
    }
}