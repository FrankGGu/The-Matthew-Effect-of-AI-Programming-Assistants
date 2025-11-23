import java.util.Arrays;

class Solution {
    public int countCoveredBuildings(int[][] ranges) {
        Arrays.sort(ranges, (a, b) -> a[0] - b[0]);
        int count = 0;
        int end = -1;
        for (int[] range : ranges) {
            if (range[0] > end) {
                count++;
                end = range[1];
            } else {
                end = Math.max(end, range[1]);
            }
        }
        return count;
    }
}