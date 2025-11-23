class Solution {
    public int addRungs(int[] rungs, int dist) {
        int count = 0;
        int currentHeight = 0;
        for (int rung : rungs) {
            if (rung - currentHeight > dist) {
                count += (rung - currentHeight - 1) / dist;
            }
            currentHeight = rung;
        }
        return count;
    }
}