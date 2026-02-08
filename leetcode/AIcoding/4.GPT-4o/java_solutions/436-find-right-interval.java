import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int[] findRightInterval(int[][] intervals) {
        int n = intervals.length;
        int[] result = new int[n];
        int[][] indexedIntervals = new int[n][2];

        for (int i = 0; i < n; i++) {
            indexedIntervals[i][0] = intervals[i][0];
            indexedIntervals[i][1] = i;
        }

        Arrays.sort(indexedIntervals, Comparator.comparingInt(a -> a[0]));

        for (int i = 0; i < n; i++) {
            int target = intervals[i][1];
            int low = 0, high = n - 1, rightIntervalIndex = -1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (indexedIntervals[mid][0] >= target) {
                    rightIntervalIndex = indexedIntervals[mid][1];
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            result[i] = rightIntervalIndex;
        }

        return result;
    }
}