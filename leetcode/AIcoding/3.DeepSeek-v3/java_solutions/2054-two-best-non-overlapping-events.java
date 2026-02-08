import java.util.Arrays;

class Solution {
    public int maxTwoEvents(int[][] events) {
        Arrays.sort(events, (a, b) -> a[0] - b[0]);
        int n = events.length;
        int[] maxAfter = new int[n + 1];
        for (int i = n - 1; i >= 0; i--) {
            maxAfter[i] = Math.max(maxAfter[i + 1], events[i][2]);
        }
        int max = 0;
        for (int i = 0; i < n; i++) {
            int start = events[i][0];
            int end = events[i][1];
            int val = events[i][2];
            max = Math.max(max, val);
            int left = i + 1, right = n;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (events[mid][0] > end) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            if (left < n) {
                max = Math.max(max, val + maxAfter[left]);
            }
        }
        return max;
    }
}