import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

class Solution {
    public int[] findRightInterval(int[][] intervals) {
        int n = intervals.length;
        int[] result = new int[n];

        List<int[]> startPoints = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            startPoints.add(new int[]{intervals[i][0], i}); // {start_value, original_index}
        }

        // Sort the list based on start values
        Collections.sort(startPoints, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                return a[0] - b[0];
            }
        });

        for (int i = 0; i < n; i++) {
            int targetEnd = intervals[i][1];

            int left = 0;
            int right = n - 1;
            int bestMatchOriginalIndex = -1;

            // Binary search to find the smallest start_j >= targetEnd
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (startPoints.get(mid)[0] >= targetEnd) {
                    bestMatchOriginalIndex = startPoints.get(mid)[1]; // This is a potential candidate
                    right = mid - 1; // Try to find an even smaller start value in the left half
                } else {
                    left = mid + 1; // Current start value is too small, look in the right half
                }
            }
            result[i] = bestMatchOriginalIndex;
        }

        return result;
    }
}