import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] findRightInterval(int[][] intervals) {
        int n = intervals.length;
        int[] result = new int[n];
        Map<Integer, Integer> startMap = new HashMap<>();
        int[][] startIntervals = new int[n][2];

        for (int i = 0; i < n; i++) {
            startMap.put(intervals[i][0], i);
            startIntervals[i][0] = intervals[i][0];
            startIntervals[i][1] = i;
        }

        Arrays.sort(startIntervals, (a, b) -> a[0] - b[0]);

        for (int i = 0; i < n; i++) {
            int end = intervals[i][1];
            int rightIntervalIndex = -1;

            int left = 0;
            int right = n - 1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (startIntervals[mid][0] >= end) {
                    rightIntervalIndex = startIntervals[mid][1];
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            result[i] = rightIntervalIndex;
        }

        return result;
    }
}