public class Solution {
    public int addRungs(int[] rungs, int dist) {
        int prev = 0;
        int count = 0;
        for (int height : rungs) {
            int gap = height - prev;
            if (gap > dist) {
                count += (gap - 1) / dist;
            }
            prev = height;
        }
        return count;
    }
}