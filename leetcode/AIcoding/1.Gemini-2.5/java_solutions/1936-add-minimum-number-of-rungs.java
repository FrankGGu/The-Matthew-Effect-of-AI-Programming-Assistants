class Solution {
    public long addRungs(int[] rungs, int dist) {
        long addedRungs = 0;
        int currentHeight = 0;

        for (int rung : rungs) {
            int gap = rung - currentHeight;
            if (gap > dist) {
                addedRungs += (long) (gap - 1) / dist;
            }
            currentHeight = rung;
        }

        return addedRungs;
    }
}