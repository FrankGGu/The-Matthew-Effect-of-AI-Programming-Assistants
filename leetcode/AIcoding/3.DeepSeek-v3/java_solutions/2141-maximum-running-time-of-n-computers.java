class Solution {
    public long maxRunTime(int n, int[] batteries) {
        long left = 0;
        long right = 0;
        for (int b : batteries) {
            right += b;
        }
        right /= n;

        long res = 0;
        while (left <= right) {
            long mid = left + (right - left) / 2;
            if (canRun(n, batteries, mid)) {
                res = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return res;
    }

    private boolean canRun(int n, int[] batteries, long time) {
        long total = 0;
        for (int b : batteries) {
            total += Math.min(b, time);
            if (total >= time * n) {
                return true;
            }
        }
        return total >= time * n;
    }
}