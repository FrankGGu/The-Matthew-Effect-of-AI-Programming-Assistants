class Solution {
    public int minTime(int[] time, int m) {
        int left = 0;
        int right = 0;
        for (int t : time) {
            right += t;
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canFinish(time, m, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canFinish(int[] time, int m, int limit) {
        int days = 1;
        int maxTime = 0;
        int sum = 0;

        for (int t : time) {
            sum += t;
            maxTime = Math.max(maxTime, t);
            if (sum - maxTime > limit) {
                days++;
                sum = t;
                maxTime = t;
                if (days > m) {
                    return false;
                }
            }
        }
        return true;
    }
}