public class Solution {

import java.util.*;

public class Solution {
    public int maxTwoEvents(int[][] events) {
        int n = events.length;
        int[][] sorted = new int[n][3];
        for (int i = 0; i < n; i++) {
            sorted[i][0] = events[i][0];
            sorted[i][1] = events[i][1];
            sorted[i][2] = events[i][2];
        }
        Arrays.sort(sorted, (a, b) -> a[0] - b[0]);

        int[] endTimes = new int[n];
        for (int i = 0; i < n; i++) {
            endTimes[i] = sorted[i][1];
        }

        int[] maxEventValue = new int[n];
        int maxVal = 0;
        for (int i = n - 1; i >= 0; i--) {
            maxVal = Math.max(maxVal, sorted[i][2]);
            maxEventValue[i] = maxVal;
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            int startTime = sorted[i][0];
            int endTime = sorted[i][1];
            int value = sorted[i][2];

            int left = 0;
            int right = n - 1;
            int idx = -1;
            while (left <= right) {
                int mid = (left + right) / 2;
                if (endTimes[mid] < startTime) {
                    idx = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (idx != -1) {
                result = Math.max(result, value + maxEventValue[idx]);
            } else {
                result = Math.max(result, value);
            }
        }

        return result;
    }
}
}