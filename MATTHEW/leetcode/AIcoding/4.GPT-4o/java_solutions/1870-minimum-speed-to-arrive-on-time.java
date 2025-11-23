class Solution {
    public int minSpeedOnTime(int[] dist, double hour) {
        int left = 1, right = 10000000;
        int result = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canArriveOnTime(dist, hour, mid)) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return result;
    }

    private boolean canArriveOnTime(int[] dist, double hour, int speed) {
        double time = 0;
        for (int i = 0; i < dist.length; i++) {
            time += (double) dist[i] / speed;
            if (i < dist.length - 1) {
                time = Math.ceil(time);
            }
        }
        return time <= hour;
    }
}