class Solution {
    public int numberOfArrays(int n, int[] differences, int lower, int upper) {
        long min = 0, max = 0, current = 0;
        for (int diff : differences) {
            current += diff;
            min = Math.min(min, current);
            max = Math.max(max, current);
        }

        long range = upper - lower;
        long requiredRange = max - min;

        if (requiredRange > range) {
            return 0;
        }

        return (int) (range - requiredRange + 1);
    }
}