public class Solution {

import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int[] findRightInterval(int[][] intervals) {
        int n = intervals.length;
        int[][] sortedIntervals = new int[n][3];

        for (int i = 0; i < n; i++) {
            sortedIntervals[i][0] = intervals[i][0];
            sortedIntervals[i][1] = intervals[i][1];
            sortedIntervals[i][2] = i;
        }

        Arrays.sort(sortedIntervals, Comparator.comparingInt(a -> a[0]));

        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            int left = 0;
            int right = n - 1;
            int res = -1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (sortedIntervals[mid][0] >= intervals[i][1]) {
                    res = sortedIntervals[mid][2];
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            result[i] = res;
        }

        return result;
    }
}
}