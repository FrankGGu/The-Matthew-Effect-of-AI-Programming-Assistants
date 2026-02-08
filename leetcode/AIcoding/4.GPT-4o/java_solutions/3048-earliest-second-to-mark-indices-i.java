class Solution {
    public int earliestFullMark(int[] times) {
        boolean[] marked = new boolean[times.length];
        int count = 0;

        for (int time : times) {
            if (time < times.length && !marked[time]) {
                marked[time] = true;
                count++;
            }
            if (count == times.length) {
                return time;
            }
        }
        return -1;
    }
}