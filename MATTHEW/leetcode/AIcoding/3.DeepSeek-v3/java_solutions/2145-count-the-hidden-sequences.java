class Solution {
    public int numberOfArrays(int[] differences, int lower, int upper) {
        long min = 0, max = 0;
        long current = 0;
        for (int diff : differences) {
            current += diff;
            min = Math.min(min, current);
            max = Math.max(max, current);
        }
        long total = (upper - lower) - (max - min) + 1;
        return total < 0 ? 0 : (int) total;
    }
}