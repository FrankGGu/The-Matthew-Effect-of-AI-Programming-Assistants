import java.util.Arrays;

class Solution {
    public int maxTwoEvents(int[][] events) {
        int n = events.length;

        // Sort events by start time
        Arrays.sort(events, (a, b) -> a[0] - b[0]);

        // max_value_after[i] stores the maximum value of any single event from index i to n-1
        int[] max_value_after = new int[n];
        max_value_after[n - 1] = events[n - 1][2];
        for (int i = n - 2; i >= 0; i--) {
            max_value_after[i] = Math.max(events[i][2], max_value_after[i + 1]);
        }

        int maxTotalValue = 0;

        // Iterate through each event as the first event
        for (int i = 0; i < n; i++) {
            // Case 1: Attend only this event
            maxTotalValue = Math.max(maxTotalValue, events[i][2]);

            // Case 2: Attend this event and one non-overlapping event after it
            // Find the first event whose start time is strictly greater than events[i]'s end time
            int low = i + 1;
            int high = n - 1;
            int nextEventIdx = n; // Default to n if no such event found

            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (events[mid][0] > events[i][1]) {
                    nextEventIdx = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }

            // If a non-overlapping event is found, combine values
            if (nextEventIdx < n) {
                maxTotalValue = Math.max(maxTotalValue, events[i][2] + max_value_after[nextEventIdx]);
            }
        }

        return maxTotalValue;
    }
}