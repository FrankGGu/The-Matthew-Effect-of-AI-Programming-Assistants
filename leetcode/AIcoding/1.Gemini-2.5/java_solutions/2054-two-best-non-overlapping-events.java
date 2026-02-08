import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int maxTwoEvents(int[][] events) {
        Arrays.sort(events, Comparator.comparingInt(a -> a[0]));

        int n = events.length;

        int[] maxValAfterIndex = new int[n + 1];
        maxValAfterIndex[n] = 0; 

        for (int i = n - 1; i >= 0; i--) {
            maxValAfterIndex[i] = Math.max(events[i][2], maxValAfterIndex[i + 1]);
        }

        int maxTotalValue = 0;

        for (int i = 0; i < n; i++) {
            int currentEventValue = events[i][2];
            maxTotalValue = Math.max(maxTotalValue, currentEventValue);

            int currentEventEndTime = events[i][1];

            int nextEventStartIndex = findNextEventIndex(events, currentEventEndTime, i + 1, n - 1);

            if (nextEventStartIndex < n) {
                maxTotalValue = Math.max(maxTotalValue, currentEventValue + maxValAfterIndex[nextEventStartIndex]);
            }
        }

        return maxTotalValue;
    }

    private int findNextEventIndex(int[][] events, int targetEndTime, int low, int high) {
        int resultIndex = events.length;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (events[mid][0] > targetEndTime) {
                resultIndex = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return resultIndex;
    }
}