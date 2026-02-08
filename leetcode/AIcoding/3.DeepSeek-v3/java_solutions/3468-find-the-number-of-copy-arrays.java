class Solution {
    public int numberOfArrays(int[] differences, int lower, int upper) {
        long min = 0, max = 0;
        long current = 0;
        for (int diff : differences) {
            current += diff;
            min = Math.min(min, current);
            max = Math.max(max, current);
        }
        long lowerBound = lower - min;
        long upperBound = upper - max;
        if (lowerBound > upperBound) {
            return 0;
        }
        return (int) (upperBound - lowerBound + 1);
    }
}