import java.util.Arrays;

class Solution {
    public long findMinimumTime(int[] time, int[] amount) {
        int n = time.length;
        int[][] items = new int[n][2];
        for (int i = 0; i < n; i++) {
            items[i][0] = time[i];
            items[i][1] = amount[i];
        }

        Arrays.sort(items, (a, b) -> a[0] - b[0]);

        long left = 0;
        long right = 0;
        for (int i = 0; i < n; i++) {
            right += (long) items[i][0] * items[i][1];
        }

        long ans = right;

        while (left <= right) {
            long mid = left + (right - left) / 2;
            long totalTime = 0;
            boolean possible = true;
            for (int i = 0; i < n; i++) {
                if ((long) items[i][0] * items[i][1] > mid) {
                    totalTime += (mid / items[i][0]);
                } else {
                    totalTime += items[i][1];
                }
            }

            if (totalTime >= Arrays.stream(amount).sum()) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
}