class Solution {
    public int addRungs(int[] rungs, int dist) {
        int res = 0;
        int prev = 0;
        for (int rung : rungs) {
            int diff = rung - prev;
            if (diff > dist) {
                res += (diff - 1) / dist;
            }
            prev = rung;
        }
        return res;
    }
}